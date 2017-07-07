#!/usr/bin/python
import jarvis_loganalytics
import os,shutil

sessionID = 595959
basepath = "/loganalytics"

from elasticsearch import Elasticsearch
es = Elasticsearch()
#Running TC-1(drive_failure_positive_case)

print "TC1_Drive_Failure_positive_case"
commandString = "./jarvis_loganalytics.py -i drive_failure -p " + basepath + "/drive_failure.txt -s" + str(sessionID) 

os.system(commandString)
responseFolderPath = basepath + '/' + str(sessionID)
responseFilePath = basepath + '/' + str(sessionID) + '/response'

while ((os.path.isfile(responseFilePath) == 0) and
       (os.path.getsize(responseFilePath) > 0)): 
    print "Waiting for response file to be created"
    time.sleep(5)

print "File got created"
checktext = "failed due to"

if checktext in open(responseFilePath).read():
    print "Test is Passed"
else:
    print "Test Failed"

shutil.rmtree(responseFolderPath)
es.indices.delete(index=str(sessionID), ignore=[400, 404])

#Running TC-2(drive_failure_Negetive_case)
print "TC2_Drive_Failure_Negetive_case"
sessionID = sessionID + 1
commandString = "./jarvis_loganalytics.py -i drive_failure -p " + basepath + "/drive_failure_neg.txt -s" + str(sessionID)

os.system(commandString)
responseFolderPath = basepath + '/' + str(sessionID)
responseFilePath = basepath + '/' + str(sessionID) + '/response'

while ((os.path.isfile(responseFilePath) == 0) and
       (os.path.getsize(responseFilePath) > 0)):
    print "Waiting for response file to be created"
    time.sleep(5)

print "File got created"
checktext = "No Pattern Found"

if checktext in open(responseFilePath).read():
    print "Test is Passed"
else:
    print "Test Failed"

shutil.rmtree(responseFolderPath)
es.indices.delete(index=str(sessionID), ignore=[400, 404])

#Running TC-3(sp_servicemode_positive_case)
print "TC3_sp_servicemode_Positive_case"
sessionID = sessionID + 1
commandString = "./jarvis_loganalytics.py -i sp_servicemode -p " + basepath + "/sp_servicemode.txt -s" + str(sessionID)

os.system(commandString)
responseFolderPath = basepath + '/' + str(sessionID)
responseFilePath = basepath + '/' + str(sessionID) + '/response'

while ((os.path.isfile(responseFilePath) == 0) and
       (os.path.getsize(responseFilePath) > 0)):
    print "Waiting for response file to be created"
    time.sleep(5)

print "File got created"
checktext = "The SP is in service mode"

if checktext in open(responseFilePath).read():
    print "Test is Passed"
else:
    print "Test Failed"

shutil.rmtree(responseFolderPath)
es.indices.delete(index=str(sessionID), ignore=[400, 404])

#Running TC-4(sp_servicemode_neg_case)
print "TC4_sp_servicemode_Negetive__case"
sessionID = sessionID + 1
commandString = "./jarvis_loganalytics.py -i sp_servicemode -p " + basepath + "/sp_servicemode_neg.txt -s" + str(sessionID)

os.system(commandString)
responseFolderPath = basepath + '/' + str(sessionID)
responseFilePath = basepath + '/' + str(sessionID) + '/response'

while ((os.path.isfile(responseFilePath) == 0) and
       (os.path.getsize(responseFilePath) > 0)):
    print "Waiting for response file to be created"
    time.sleep(5)

print "File got created"
checktext = "couldn't find the reason"

if checktext in open(responseFilePath).read():
    print "Test is Passed"
else:
    print "Test Failed"

shutil.rmtree(responseFolderPath)
es.indices.delete(index=str(sessionID), ignore=[400, 404])
