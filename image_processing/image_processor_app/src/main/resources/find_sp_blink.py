import cv2
import os
import numpy as np
import argparse
import json
import subprocess
import shutil

from subprocess import Popen, PIPE



parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument("-i", "--video_path", dest = 'video_path', required = True)
parser.add_argument("-o", "--output_dir", dest = 'output_dir', required = False)
    
args = parser.parse_args()




fault_sp_script = os.environ.get('WORKSPACE_IMAGE')+'/image_processor_app/src/main/resources/find_sp_fault.py'
fault_sp_script = "find_sp_fault.py"
imgFolder = "imgFolder"

if not os.path.exists(imgFolder):
    os.makedirs(imgFolder)

#print args.video_path, args.output_dir
#Output response
out_response = args.video_path.split("/")[-1].split(".")[0] + "_response.json"

frame_pre = imgFolder + "/" + args.video_path.split("/")[-1].split(".")[0].strip()+"-%03d.jpeg"

subprocess.call(["ffmpeg", "-i", args.video_path, "-r", "1", "-f", "image2", frame_pre])

# let's assume this got successfull, match the template for SP faults
# for all teh frames in folder, check !!
imageList = []
for file in os.listdir(imgFolder):
    if file.endswith(".jpeg"):
        val = os.path.join(imgFolder, file)
        imageList.append(val)

imageList.sort()
FaultList = []

for index in range(0, len(imageList)):
    subprocess.call(["python", fault_sp_script, "-i", imageList[index], "-o", imgFolder])
    jsonOut = imageList[index].split(".jpeg")[0] + "_response.json" 

    # Read jsonOut file
    with open(jsonOut) as pf:
        pData = json.load(pf)

    FaultList.append(pData["response_text"])

print "FFFF", FaultList

# Verify the List
check_F = 0
check_N = 0
check_D = 0
blink = 0
s = ""
# Create a List to keep index for Blink ON-OFF
BlinkList = []

for fl in range(0, len(FaultList)):
    if "FAULTED" in FaultList[fl]:
        s = "Running Powerup tests"
        check_F = 1
        BlinkList.append("ON")
        if check_N == 1:
            blink = 1
            check_N = 0
    elif "DEGRADED" in FaultList[fl]:
        s = "OS is loaded"
        check_D = 1
        BlinkList.append("ON")
        if check_D == 1:
            blink = 1
            check_D = 0

    if "No " in FaultList[fl]:
        BlinkList.append("OFF")
        if check_F == 1 or check_D == 1:
            blink = 1
            check_F = 0
            check_D = 0
        check_N = 1 


    if blink == 1:
        break

outputImageIndex = 0

for bIndex in range(0, len(BlinkList)):
    if "ON" in BlinkList[bIndex]:
        outputImageIndex = bIndex
 
print "Blink::", blink, s , BlinkList, outputImageIndex
img = imageList[outputImageIndex].split(".jpeg")[0] + "_processed.jpg"

subprocess.call(["mv", img, args.output_dir])
orig = args.output_dir + "/" + img.split("/")[1]
print orig
dest = orig.split(".jpg")[0].rsplit("-", 1)[0] + "_processed.jpg"

subprocess.call(["mv", orig, dest])

outDict = {}

outDict["response_text"] = s
outDict["response_image"] = dest.split("/")[-1]


outputfile = args.output_dir + "/" + out_response

with open(outputfile, 'w') as outfile:
    json.dump(outDict, outfile)

shutil.rmtree(imgFolder)
