#!/usr/bin/python
from datetime import datetime
from elasticsearch import Elasticsearch
import os, time, subprocess
from shutil import copy
import shutil
import fileinput
import pandas as pd

service_mode_reason = {'0x80b8':'Invalid Disk Type is detected',
                       '0x80bf':'The first 4 disks in the DPE has mismatched types',
                       '0x80cl':'The first 4 disks in the DPE has mismatched size',
                       '0x80b8':'Invalid Disk Type is detected',
                       '0x8001':'Fault detected in CPU. The storage processor has failed need to replace this SP'}

Pattern1 = {"query":{
                "match_phrase": {"message": "PDO has set Drive Fault"}
               }}

es_dh_query = ""
sample_config_folder = os.path.dirname(os.path.abspath(__file__))


logstashdir = "/opt/logstash"
logstashexec = "/opt/logstash/bin/logstash"
elasticsearchhost = "localhost:9200"
base_dir = "/loganalytics"
responsefilename = "response"

class loganalytics:
    def __init__(self):
        self.df = []
        response_file_path = ""
    
    # Write response to the given file
    def PrintResponseToResultFile(self,response):
        file = open(self.response_file_path, "w")
        file.write(response)
        file.close
        print (self.response_file_path)
    
    # Copy sammple config file to target directory and repalce log file & elasticsearch
    # index in config file with actual values
    def CreateConfigFile(self, targetdir, session, logfilename, sampleconfigfile):
        #print(targetdir)
        #print(logfilename)
        #print("copied config file to target directory")
        copy(sampleconfigfile, targetdir)
        newconfigfile = targetdir + "/" + os.path.basename(sampleconfigfile)

        #print(newconfigfile)
    
        tempFile = open( newconfigfile, 'r+' )

        pathmatch = "pathtobereplaced"
        indexmatch = "indextobereplaced"
        newlogpath = targetdir + "/" + logfilename
        newindexname = str(session)
        #print(newindexname)

        #print(newlogpath)
        for line in fileinput.input( newconfigfile ):
            newline = ""
            if pathmatch in line :
                newline = line.replace( pathmatch, newlogpath ) 
            elif indexmatch in line:
                newline = line.replace( indexmatch, newindexname ) 
            else:
                newline = line.replace( indexmatch, newindexname ) 
            tempFile.write(newline)
    
        tempFile.close() 

    def InitiateLogstash(self, configfile, session):
        os.chdir(logstashdir)
        path = os.getcwd()
        #print path
        #os.system("./bin/logstash -f /etc/logstash/conf.d/logstash.conf &")        
        #time.sleep(90)
        #subprocess.call("/opt/logstash/bin/logstash -f /etc/logstash/conf.d/logstash.conf")
        proc = subprocess.Popen([logstashexec,"-f",configfile])
        es = Elasticsearch([elasticsearchhost])
        while (es.indices.exists(session)) == 0 :
            #print("index is not there")
            time.sleep(5)
        #else: 
        #    print "no index"

        time.sleep(5)
        pid = proc.pid
        proc.terminate()
           
   
    def GetResponseForDriveErrorCode(self, errorcode):
        if(errorcode == "0x22d0006"):
	    return("(Activate timer expired.)\nRecommendation: Please remove the drive from the slot and re-insert it. It should fix the issue")
	elif(errorcode == "0x2600003"):
            return("(Media error threshold exceeded.)\nRecommendation: Drive needs to be replaced. Please log a service ticket to get it replaced.")
            

    def QueryElasticsearchAndPopulateDataframe(self, es, query, session, desiredcol):
        res = es.search(index=session, body=query)

        for hit in res['hits']['hits']:
            for record in hit["_source"].keys():
                if record== 'message':
                    Bus = hit["_source"][u'bus']
                    Encl = hit["_source"][u'encl']
                    Disk = hit["_source"][u'disk']

                    drive = Bus + "_" + Encl + "_" + Disk

                    if(self.df['drive'].str.contains(drive).any()):
                        cur_value = self.df.loc[self.df["drive"]==drive,desiredcol]
                        self.df.loc[self.df["drive"]==drive,desiredcol] = cur_value + 1
                    else:
                        raw_data = {'drive':[drive], 'pfa_hw':[0], 'timeout':[0], 'parity':[0], 'bad_blks':[0], 'inv_sec':[0], 'recon_sec':[0], 'rec_by_drv':[0]}
                        localdf = pd.DataFrame(raw_data,columns = ['drive', 'pfa_hw', 'timeout', 'parity', 'bad_blks', 'inv_sec', 'recon_sec', 'rec_by_drv'])
                        cur_value = localdf.loc[localdf["drive"]==drive,desiredcol]
                        localdf.loc[localdf["drive"]==drive,desiredcol] = cur_value + 1

                        frames = [self.df, localdf]
                        self.df = pd.concat(frames)

    def AnalyzeLog(self,path,intent,session,drives):
        drives = drives.replace("[","")
        drives = drives.replace("]","")
        drivelist = drives.split(",")
        session = session.lower()
        # Create directory with session id for further processing.
        dir_path = base_dir + "/" + str(session)

	self.response_file_path = dir_path + "/" + responsefilename
	
        # See if directory is already existed. If yes then fail the request as session ID should
        # be unique.
        if os.path.exists(dir_path):            
            #print(dir_path + " is already existed.")
            shutil.rmtree(dir_path)
            #self.PrintResponseToResultFile("Directory with session Id:" + session + " is already existed", response_file_path)
            #return
        
        # Copy provided log file(s) to the temporary direcotry created with session id.
        os.makedirs(dir_path)
	#print("Created directory " + dir_path)
        copy(path, dir_path)
        #print("Copied log file from " + path + " to " + dir_path)
           
        logfilename = os.path.basename(path)
        if (intent == "pool_offline"):
            #print "log is being analyzed to diagnose pool offline issue."
            dir = ""

        elif (intent == "drive_failure"):
            #print "log is being analyzed to diagnose drive failure issue."
            
            sampleconfigfile = sample_config_folder + "/" + "drive_failure.conf"
            #sampleconfigfile = "drive_failure.conf"
            self.CreateConfigFile(dir_path, session, logfilename, sampleconfigfile)

            configfile = dir_path + "/" + "drive_failure.conf"
            self.InitiateLogstash(configfile, session)

            query  = { "query": {"match_phrase": {"message": "taken offline."} } }
            # Create elasticsearch object.
            es = Elasticsearch([elasticsearchhost])
            res = es.search(index=session,
                         body = query)

            hit_count = res['hits']['total']
           
            Final_output = "" 
            if hit_count == 0:
               Final_output = "No Pattern Found"
            else:
                for hit in res['hits']['hits']:
     
                    for record in hit["_source"].keys():
                        if record== 'message':
                            Bus = hit["_source"][u'bus']
                            Encl = hit["_source"][u'encl']
                            Disk = hit["_source"][u'disk']
                         
                            dae = Bus+"_"+Encl+"_"+Disk
                            if dae in drivelist or drives == "":
                                err_code = hit["_source"][u'err_code']
                                response = "Drive:" + dae + " is failed due to " + err_code + self.GetResponseForDriveErrorCode(err_code)
                                Final_output = Final_output + response + "\n\n"
                                
            self.PrintResponseToResultFile(Final_output)

            
        elif (intent == "sp_servicemode"):
            
            sampleconfigfile = sample_config_folder + "/" + "sp_servicemode.conf"
            #sampleconfigfile = "sp_servicemode.conf"
            self.CreateConfigFile(dir_path, session, logfilename, sampleconfigfile)

            configfile = dir_path + "/" + "sp_servicemode.conf"
            self.InitiateLogstash(configfile, session)

            #print "log is being analyzed to diagnose SP in service mode issue."
            base_string = "The SP is in service mode and the reason is -"
            return_string = base_string + "Sorry! couldn't find the reason"

            es = Elasticsearch([elasticsearchhost])  # use default of localhost, port 9200
            matches = es.search(index=session, q='name:"Rescue Reason"')
            hits = matches['hits']['hits']
         
            #print "Matched count - hit"
            #if matches.get('hits') is not None and matches['hits'].get('hits') is not None:
                #print "Matched found"
            for hit in hits:
                error_code = hit['_source']['value'] 
                error_code = error_code.replace("\r","")
                if error_code in service_mode_reason:
                    return_string = base_string + service_mode_reason[error_code]
            
            self.PrintResponseToResultFile(return_string)
      
        elif (intent == "drive_healthcheck"):
            #print("log is being analyzed for drive_healthcheck issue")            
            
            sampleconfigfile = sample_config_folder + "/" + "drive_healthcheck.conf"
            self.CreateConfigFile(dir_path, session, logfilename, sampleconfigfile)

            configfile = dir_path + "/" + "drive_healthcheck.conf"
            
            self.InitiateLogstash(configfile, session)
     
            
            es = Elasticsearch([elasticsearchhost])

            raw_data = {}
            self.df = pd.DataFrame(raw_data, columns = ['drive', 'pfa_hw', 'timeout', 'parity', 'bad_blks', 'inv_sec', 'recon_sec', 'rec_by_drv'])
        
            #Query 1 for "bad_blks"
            es_dh_query  = { "query": {"match_phrase": {"message": "820 Soft Media Error [Bad block]"} } }
            desiredcol = "bad_blks"    
            self.QueryElasticsearchAndPopulateDataframe(es, es_dh_query, session, desiredcol)
           
            #Query 2 for "inv_sec"
            es_dh_query  = { "query": {"match_phrase": {"message": "840 Data Sector Invalidated"} } }
            desiredcol = "inv_sec"
            self.QueryElasticsearchAndPopulateDataframe(es, es_dh_query, session, desiredcol)
 
            #Query 3 for "recon_sec"
            es_dh_query  = { "query": {"match_phrase": {"message": "689 Sector Reconstructed"} } }
            desiredcol = "recon_sec"
            self.QueryElasticsearchAndPopulateDataframe(es, es_dh_query, session, desiredcol)
            
            #Query 3 for "rec_by_drv"
            es_dh_query  = { "query": {"match_phrase": {"message": "6a0 Disk soft media error"} } }
            desiredcol = "rec_by_drv"
            self.QueryElasticsearchAndPopulateDataframe(es, es_dh_query, session, desiredcol)


            self.df.to_csv(dir_path + "/drive_healthcheck.csv")        


            


                
                




