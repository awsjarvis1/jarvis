import os
import argparse
import time
import json
import subprocess

#Hardcoded paths - for automation
inImages = os.getcwd() + "/inputTestImages"
outImages = os.getcwd() + "/outputTestImages"
#print inImages, outImages

fault_disk_script = "find_faulty_disk.py"
fault_sp_script = "find_sp_fault.py"


def main():

#    parser = argparse.ArgumentParser(description='Executing Image Tests')
#    parser.add_argument("-s", "--script_path", dest = 'script_path', required = True)
    
#    args = parser.parse_args()
 #   print args.script_path


    checkDAE = 0
    checkSP = 0
    runTests = 0
 ## Read the .ini file
    with open('check.ini') as fp:
        TC_Count = 1 
        for line in fp:
            if line.startswith("#") or line == "\n":
                continue
            # Check for DAE for faulty disks
            if line.startswith("[DAE]"):
                checkDAE = 1
                continue
            if line.startswith("[SP]"):
                checkSP = 1
                checkDAE = 0 
                continue

            image = line.split(":")[0]
            imagePath = inImages + "/" + image.strip() 
            val = line.split(":")[1]

            if checkSP == 1:
#                print "val string in SP", val
                subprocess.call(["python", fault_sp_script, "-i", imagePath, "-o", outImages], stdout=FNULL, stderr=subprocess.STDOUT) 
                runTests = 1
                
            if checkDAE == 1:
                encl_List = []
                FNULL = open(os.devnull, 'w')

                subprocess.call(["python", fault_disk_script, "-i", imagePath, "-o", outImages], stdout=FNULL, stderr=subprocess.STDOUT) 
                runTests = 1

            if runTests == 1:
                runTests = 0
                # if all successful, there must be file in outImages with .json. Let's read it and verify the output.
                trunc_image = imagePath.rsplit("/")[-1].split(".jpg")[0]
                processed_file = outImages + "/" + trunc_image + "_processed.jpg"
  
                response_file = outImages + "/" + trunc_image + "_response.json"
                string = "TC:" + str(TC_Count) +  "--" + "Does Out processed file exists for image " + image + "?"
                TC_Count += 1
                if os.path.isfile(processed_file):
                    print string, "PASSED" 
                else:
                    print string, "FAILED"
            
                string  = "TC:" + str(TC_Count) + "--" + "Does Out json file exists for image " + image + "?"
                TC_Count += 1
                if os.path.isfile(response_file):
                    print string, "PASSED" 
                else:
                    print string, "FAILED" 

                # Validaing json output
                with open(response_file) as pf:
                    pData = json.load(pf)
 
                string  = "TC:" + str(TC_Count) + "--" + "Validating Out json file : response_image has correct output path for " + image + "?" 
                TC_Count += 1
                if pData["response_image"] == processed_file.split("/")[-1].strip():
                    print string, "PASSED"
                else:
                    print string, "FAILED"

            #    string  = "TC:" + str(TC_Count) + "--" + "Validating Out json file : RESPONSE for " + image + "?" 
            #    TC_Count += 1

            #    for i in range(1,len(pData["response_text"].split("\n")) - 1):
            #        value = pData["response_text"].split("\n")[i].split(":")[1].strip()
            #        if value == "NONE":
            #            continue 
            #        if value == encl_List[i-1].strip():
            #            print string, "PASSED"
            #        else:
            #            print string, "FAILED"

        

if __name__ == '__main__':
    main()
