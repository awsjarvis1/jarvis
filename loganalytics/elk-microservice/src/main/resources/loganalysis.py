#!/usr/bin/python
from datetime import datetime
import os, time, subprocess
from shutil import copy
import shutil
import fileinput
import pandas as pd
from elprocessing import ELProcessing
from weka import WekaLogAnalytics
from subprocess import *
import json

service_mode_reason = {'0x80b8':'Invalid Disk Type is detected',
                       '0x80bf':'The first 4 disks in the DPE has mismatched types',
                       '0x80cl':'The first 4 disks in the DPE has mismatched size',
                       '0x80b8':'Invalid Disk Type is detected',
                       '0x8001':'Fault detected in CPU. The storage processor has failed need to replace this SP'}

sample_config_folder = os.path.dirname(os.path.abspath(__file__))

WEKA_NUMERIC_HEADER = "@relation drive_health\n\
\n\
@attribute pfa_hw numeric\n\
@attribute timeout numeric\n\
@attribute parity numeric\n\
@attribute bad_blks numeric\n\
@attribute inv_sec numeric\n\
@attribute recon_sec numeric\n\
@attribute rec_by_drv numeric\n\
@attribute state {pass, fail}\n\
\n\
@data\n"

BASE_DIR = "/loganalytics"
responsefilename = "response"

class LogAnalytics:
    def __init__(self):
        self.df = []
        self.response_file_path = ""
        self.elp = ELProcessing()
        self.log_path = ""
    
    def PrintResponseToResultFile(self,response):
        ''' Write response to the given file
        '''
        file = open(self.response_file_path, "w")
        file.write(response)
        file.close
        print (self.response_file_path)
    
    def CreateConfigFile(self, targetdir, session, logfilename, sampleconfigfile):
        ''' Copy sammple config file to target directory and repalce log file & elasticsearch
            index in config file with actual values
        '''
        copy(sampleconfigfile, targetdir)
        newconfigfilepath = targetdir + "/" + os.path.basename(sampleconfigfile)

        tempFile = open( newconfigfilepath, 'r+' )

        pathmatch = "pathtobereplaced"
        indexmatch = "indextobereplaced"
        newlogpath = targetdir + "/" + logfilename
        newindexname = str(session)

        for line in fileinput.input( newconfigfilepath ):
            newline = ""
            if pathmatch in line :
                newline = line.replace( pathmatch, newlogpath ) 
            elif indexmatch in line:
                newline = line.replace( indexmatch, newindexname ) 
            else:
                newline = line.replace( indexmatch, newindexname ) 
            tempFile.write(newline)
    
        tempFile.close()

        return newconfigfilepath

    def GetResponseForDriveErrorCode(self, errorcode):
        if(errorcode == "0x22d0006"):
	    return("(Activate timer expired.)\nRecommendation: Please remove the drive from the slot and re-insert it. It should fix the issue")
	elif(errorcode == "0x2600003"):
            return("(Media error threshold exceeded.)\nRecommendation: Drive needs to be replaced. Please log a service ticket to get it replaced.")
            
    def QueryElasticsearchAndPopulateDataframe(self, query, session, desiredcol):
        ''' Queries elasticsearch based on the query string provided and
            populate the data frame. It also increments the value of
            desired column.
        '''

        # TODO: if there are >10000+ records then need to handle it.
        res = self.elp.QueryElasticsearch(query, session)

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
        ''' Main entry function for log analytics. Based on the
            intent it does various log analysis and provide the
            root cause and recommendation.
        '''
        drives = drives.replace("[","")
        drives = drives.replace("]","")
        drivelist = drives.split(",")
        session = session.lower()
        self.log_path = path
        
        # Create directory with session id for further processing.
        session_dir_path = BASE_DIR + "/" + str(session)

	self.response_file_path = session_dir_path + "/" + responsefilename
	
        # See if directory is already existed. If yes then fail the request as session ID should
        # be unique.
        if os.path.exists(session_dir_path):            
            shutil.rmtree(session_dir_path)
        
        # Copy provided log file(s) to the temporary direcotry created with session id.
        os.makedirs(session_dir_path)

        copy(path, session_dir_path)
           
        logfilename = os.path.basename(path)
        if (intent == "drive_failure"):
            sampleconfigfile = sample_config_folder + "/" + "drive_failure.conf"
            configfilepath = self.CreateConfigFile(session_dir_path, session, logfilename, sampleconfigfile)
            
            self.elp.InitiateLogstash(configfilepath, session)

            # Query elasticsearch.
            query  = { "query": {"match_phrase": {"message": "taken offline."} } }
            res = self.elp.QueryElasticsearch(query, session)

            hit_count = res['hits']['total']
           
            final_output = "" 
            if hit_count == 0:
               final_output = "Unable to root cause the issue. Please create service request for the further assistance"
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
                                final_output = final_output + response + "\n\n"
                                
            self.PrintResponseToResultFile(final_output)

        elif (intent == "sp_servicemode"):
            sampleconfigfile = sample_config_folder + "/" + "sp_servicemode.conf"
            
            configfilepath = self.CreateConfigFile(session_dir_path, session, logfilename, sampleconfigfile)

            configfile = session_dir_path + "/" + "sp_servicemode.conf"
            self.elp.InitiateLogstash(configfilepath, session)

            base_string = "The SP is in service mode and the reason is -"
            return_string = base_string + "Sorry! couldn't find the reason"

            query  = { "query": {"match_phrase": {"message": "Rescue Reason"} } }
            matches = self.elp.QueryElasticsearch(query, session)

            hits = matches['hits']['hits']
            hit_count = matches['hits']['total']
           
            if hit_count == 0:
               return_string = "Unable to root cause the issue. Please create service request for the further assistance"
            else:
                for hit in hits:
                    error_code = hit['_source']['value'] 
                    error_code = error_code.replace("\r","")
                    if error_code in service_mode_reason:
                        return_string = base_string + service_mode_reason[error_code]
            
            self.PrintResponseToResultFile(return_string)
      
        elif (intent == "drive_healthcheck"):
            sampleconfigfile = sample_config_folder + "/" + "drive_healthcheck.conf"
            configfilepath = self.CreateConfigFile(session_dir_path, session, logfilename, sampleconfigfile)

            self.elp.InitiateLogstash(configfilepath, session)
     
            raw_data = {}
            self.df = pd.DataFrame(raw_data, columns = ['drive', 'pfa_hw', 'timeout', 'parity', 'bad_blks', 'inv_sec', 'recon_sec', 'rec_by_drv'])
        
            #Query 1 for "bad_blks"
            es_dh_query  = { "query": {"match_phrase": {"message": "820 Soft Media Error [Bad block]"} } }
            desiredcol = "bad_blks"    
            self.QueryElasticsearchAndPopulateDataframe(es_dh_query, session, desiredcol)
           
            #Query 2 for "inv_sec"
            es_dh_query  = { "query": {"match_phrase": {"message": "840 Data Sector Invalidated"} } }
            desiredcol = "inv_sec"
            self.QueryElasticsearchAndPopulateDataframe(es_dh_query, session, desiredcol)
 
            #Query 3 for "recon_sec"
            es_dh_query  = { "query": {"match_phrase": {"message": "689 Sector Reconstructed"} } }
            desiredcol = "recon_sec"
            self.QueryElasticsearchAndPopulateDataframe(es_dh_query, session, desiredcol)
            
            #Query 3 for "rec_by_drv"
            es_dh_query  = { "query": {"match_phrase": {"message": "6a0 Disk soft media error"} } }
            desiredcol = "rec_by_drv"
            self.QueryElasticsearchAndPopulateDataframe(es_dh_query, session, desiredcol)

            test_file_path = session_dir_path + "/drive_healthcheck.arff"

            self.df.to_csv(test_file_path)

            f = open(test_file_path, "a")
            f.seek(0)
            f.write(WEKA_NUMERIC_HEADER)
            f.close()

        elif(intent == "log_analytics"):
            
            weka = WekaLogAnalytics(BASE_DIR, sample_config_folder + "/weka_miniport_filters.txt", sample_config_folder + "/weka_miniport.conf", session)
            test_data_file = weka.PrepareTestData(self.log_path)
            weka_path = sample_config_folder + "/WekaService-0.0.1-SNAPSHOT-jar-with-dependencies.jar"
            args = [weka_path, test_data_file, 'LogAnalytics', session]

            result = InvokeJarFile(*args)

            j = json.loads(result)

            output = j['0']
            print(output.lower())
            if output.lower() != "unknown":
                final_result = "It seems to be " + output + " issue. Please log a service request for further assistance."
            else:
                final_result = "Unable to find the root cause from the provided log. Please log a service ticket for further assistance."
            
            self.PrintResponseToResultFile(final_result)


        else:
            self.PrintResponseToResultFile("Unable to understand the intent:")


def InvokeJarFile(*args):
    ''' Invokes provided jar file with the given arguments. It listens
        stdout for any output or error
    '''
    process = Popen(['java', '-jar']+list(args), stdout=PIPE, stderr=PIPE)
    ret = []
    while process.poll() is None:
        line = process.stdout.readline()
        if line != '' and line.endswith('\n'):
            ret.append(line[:-1])
    stdout, stderr = process.communicate()
    ret += stdout.split('\n')
    if stderr != '':
        ret += stderr.split('\n')
    ret.remove('')
    result = str(ret)
    result = result.replace("[","")
    result = result.replace("]","")
    result = result.replace("'","")
    return result
