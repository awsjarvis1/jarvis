#!/usr/bin/python
from datetime import datetime
from elasticsearch import Elasticsearch
import os, time, subprocess
from shutil import copy
import fileinput

service_mode_reason = {'0x80b8':'Invalid Disk Type is detected',
                       '0x80bf':'The first 4 disks in the DPE has mismatched types',
                       '0x80cl':'The first 4 disks in the DPE has mismatched size',
                       '0x80b8':'Invalid Disk Type is detected',
                       '0x8001':'Fault detected in CPU. The storage processor has failed need to replace this SP'}

Pattern1 = {"query":{
                "match_phrase": {"message": "PDO has set Drive Fault"}
               }}

sample_config_folder = "/loganalytics/sampleconfig"
logstashdir = "/opt/logstash"
logstashexec = "/opt/logstash/bin/logstash"
elasticsearchhost = "localhost:9200"
base_dir = "/loganalytics"
responsefilename = "response"

class loganalytics:

    # Write response to the given file
    def PrintResponseToResultFile(self,response,filepath):
        file = open(filepath, "w")
        file.write(response)
        file.close
        print (filepath)
    
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
        proc = subprocess.Popen(["/opt/logstash/bin/logstash","-f",configfile])
        es = Elasticsearch(['localhost:9200'])
        while (es.indices.exists(session)) == 0 :
            #print("index is not there")
            time.sleep(5)
        #else: 
        #    print "no index"

        time.sleep(5)
        pid = proc.pid
        proc.terminate()
           
   
    def GetResponseForDriveErrorCode(self, errorcode):
        if(errorcode == "01|5d|05"):
	    return("(Error prediction threshold exceeded)\nResolution: Please replace the above mentioned drive")        

    def AnalyzeLog(self,path,intent,session):
        # Create directory with session id for further processing.
        dir_path = base_dir + "/" + str(session)

	response_file_path = dir_path + "/" + responsefilename
        # See if directory is already existed. If yes then fail the request as session ID should
        # be unique.
        if os.path.exists(dir_path):            
            #print(dir_path + " is already existed.")
            self.PrintResponseToResultFile("Directory with session Id:" + session + " is already existed", response_file_path)
            return
        else:
            # Copy provided log file(s) to the temporary direcotry created with session id.
            os.makedirs(dir_path)
	    #print("Created directory " + dir_path)
            copy(path, dir_path)
            #print("Copied log file from " + path + " to " + dir_path)
           
        if (intent == "pool_offline"):
            #print "log is being analyzed to diagnose pool offline issue."
            dir = ""

        elif (intent == "drive_failure"):
            #print "log is being analyzed to diagnose drive failure issue."
            logfilename = os.path.basename(path)
            sampleconfigfile = sample_config_folder + "/" + "drive_failure.conf"
            self.CreateConfigFile(dir_path, session, logfilename, sampleconfigfile)

            configfile = dir_path + "/" + "drive_failure.conf"
            self.InitiateLogstash(configfile, session)

            # Create elasticsearch object.
            es = Elasticsearch(['localhost:9200'])
            res = es.search(index=session,
                         body = Pattern1)

            for hit in res['hits']['hits']:
 
                for record in hit["_source"].keys():
                    if record== 'message':
                        Bus = hit["_source"][u'bus']
                        Encl = hit["_source"][u'encl']
                        Disk = hit["_source"][u'disk']
                     
                        Dae = Bus+"_"+Encl+"_"+Disk
                        match_pattern = "DSK:"+Dae+": cc error,"

            Pattern2 = {"query":{
                "match_phrase": {"message": match_pattern}
                 }}

            res = es.search(index=session,
                        body =Pattern2
                        )
            #print res
         
            for hit in res['hits']['hits']:
                #print hit["_source"]
                for record in hit["_source"].keys():
                    if record== 'message':
                       errorcode = hit["_source"][u'code']
                       #print errorcode 
                   

            Final_output = "Drive:"+Dae+" failed due to errocode:"+errorcode
            Final_output = Final_output + self.GetResponseForDriveErrorCode(errorcode)
            self.PrintResponseToResultFile(Final_output,response_file_path)

            
        elif (intent == "sp_servicemode"):
            logfilename = os.path.basename(path)
            sampleconfigfile = sample_config_folder + "/" + "sp_servicemode.conf"
            self.CreateConfigFile(dir_path, session, logfilename, sampleconfigfile)

            configfile = dir_path + "/" + "sp_servicemode.conf"
            self.InitiateLogstash(configfile, session)

            #print "log is being analyzed to diagnose SP in service mode issue."
            base_string = "The SP is in service mode and the reason is -"
            return_string = base_string + "Sorry! couldn't find the reason"

            es = Elasticsearch()  # use default of localhost, port 9200
            matches = es.search(index=session, q='name:"Rescue Reason"')
            hits = matches['hits']['hits']
         
            #print "Matched count - hit"
            #if matches.get('hits') is not None and matches['hits'].get('hits') is not None:
                #print "Matched found"
            for hit in hits:
                if hit['_source']['value'] in service_mode_reason:
                    return_string = base_string + service_mode_reason[hit['_source']['value']]
            
            self.PrintResponseToResultFile(return_string,response_file_path)

            


                
                



