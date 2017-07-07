from elprocessing import ELProcessing
import os
import shutil
from shutil import copy
import fileinput


TRAINING_DATA_FOLDER_NAME = "training_data"
TRAINING_DATA_FILE_NAME = "weka_training_data.arff"

TEST_DATA_FOLDER_NAME = "test_data"
TEST_DATA_FILE_NAME = "weka_query.arff"

LINE_SPERATOR = "\\r\\n"

# This needs to be copied to begining of each file which goes to weka
WEKA_FILE_HEADER = "@relation D__Zakir_Projects_EMC_PM_Hackathon_Weka-ML_Miniport_slowness \n \
\n\
@attribute text string \n\
@attribute @@class@@ {Unknown,Miniport_Slowness}\n\
\n\
@data\n\
"

class WekaLogAnalytics:
    def __init__(self, base_folder, filter_file, sample_config_file, session):
        self.elp = ELProcessing()
        self.base_folder = base_folder
        self.filter_file = filter_file        
        self.sample_config_file = sample_config_file
        self.session = session.lower()
        self.session_dir = self.base_folder + "/" + self.session

    def PrepareWeka(self):
        # See if directory is already existed. If yes then fail the request as session ID should
        # be unique.
        if os.path.exists(self.session_dir):            
            #print(dir_path + " is already existed.")
            shutil.rmtree(self.session_dir)
            #self.PrintResponseToResultFile("Directory with session Id:" + session + " is already existed", response_file_path)
            #return
        
        # Copy provided log file(s) to the temporary direcotry created with session id.
        os.makedirs(self.session_dir)

    def PrepareTestData(self, logs):
        self.pattern_name = "?"
        self.PrepareWeka()
        
        #log_folder = self.base_folder + "/" + TEST_DATA_FOLDER_NAME
        test_data_file = self.session_dir + "/" + TEST_DATA_FILE_NAME

        if os.path.isdir(logs):
            for filename in os.listdir(logs):
                print("Processing file: ", filename)
                file_path = logs + "/" + filename
                self.ProcessLogFile(file_path, test_data_file)
        else:
            self.ProcessLogFile(logs, test_data_file)

        return test_data_file
            
        
    def TrainWeka(self, pattern_name):
        self.pattern_name = pattern_name
        self.PrepareWeka()
        
        log_folder = self.base_folder + "/" + TRAINING_DATA_FOLDER_NAME
        training_data_file = self.session_dir + "/" + TRAINING_DATA_FILE_NAME
        for filename in os.listdir(log_folder):
            print("Processing file: ", filename)
            file_path = log_folder + "/" + filename
            self.ProcessLogFile(file_path, training_data_file)

    def ProcessLogFile(self, file_path, training_data_file):
        new_config_file = self.CreateConfigFile(self.session_dir, self.session, file_path, self.sample_config_file)
        self.elp.InitiateLogstash(new_config_file, self.session)

        filter_file = open(self.filter_file,'r')
        filters = filter_file.read().splitlines()

        # test data set starts with double inverted comma
        result_string = WEKA_FILE_HEADER
        result_string += '"'
        
        #for line in enumerate(filter_file):  
        for log_filter in filters:
            # strip any white space or new line characters
            log_filter = log_filter.strip()
            
            if log_filter=="":
                break

            # Need to add wildcard character as some module name contains numbers at end
            log_filter = log_filter + '*'
            
            query  = { "query": {"query_string": {"fields" : ["module"], "query": log_filter + "*"} } }

            # Query elasticsearch.
            res = self.elp.QueryElasticsearch(query, self.session)

            for hit in res['hits']['hits']:
                for record in hit["_source"].keys():
                    if record== 'message':
                        #print(hit["_source"][u'message'] + "\r\n")
                        # Add \r \n at end of the each trace as required by weka.
                        result_string += hit["_source"][u'message'] + LINE_SPERATOR

        # At end complete the data set with double inverted command and then followed by patter name
        result_string += '",' + self.pattern_name + "\n"
        
        filter_file.close()
        data_file = open(training_data_file, "a")
        data_file.write(result_string)
        data_file.close()
        
    
    def CreateConfigFile(self, targetdir, session, logfilepath, sampleconfigfile):
        ''' Copy sammple config file to target directory and repalce log file & elasticsearch
            index in config file with actual values
        '''
        #print(targetdir)
        #print(logfilename)
        #print("copied config file to target directory")
        copy(sampleconfigfile, targetdir)
        newconfigfile = targetdir + "/" + os.path.basename(sampleconfigfile)

        #print(newconfigfile)
    
        tempFile = open( newconfigfile, 'r+' )

        pathmatch = "pathtobereplaced"
        indexmatch = "indextobereplaced"
        #newlogpath = targetdir + "/" + logfilename
        newlogpath = logfilepath
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

        return newconfigfile

#weka = WekaLogAnalytics("/weka/training/miniport", "/weka/training/miniport/miniport_filters.txt", "/weka/training/miniport/miniport.conf", "bhavesh12")
#weka.TrainWeka("miniport_slowness")
#weka.PrepareTestData(logs)
