import os
import argparse
import time
import json
import subprocess

#Hardcoded paths - for automation
inImages = os.getcwd() + "/inputTestImages"
outImages = os.getcwd() + "/outputTestImages"
#print inImages, outImages

def main():

    parser = argparse.ArgumentParser(description='Executing Image Tests')
    parser.add_argument("-s", "--script_path", dest = 'script_path', required = True)
    
    args = parser.parse_args()
#    print args.script_path

 ## Read the .ini file
    with open('check.ini') as fp:
        TC_Count = 1 
        for line in fp:
            if line.startswith("#") or line == "\n":
                continue
            image = line.split(":")[0]
            imagePath = inImages + "/" + image.strip() 
            val = line.split(":")[1]
            encl_List = []
            for i in range(0, val.count("+")):
                encl_List.append(val.split("+")[i])
            encl_List.append(val.split("+")[i+1])
            FNULL = open(os.devnull, 'w')

         #   print encl_List
            subprocess.call(["python", args.script_path, "-i", imagePath, "-o", outImages], stdout=FNULL, stderr=subprocess.STDOUT) 

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
 
            string  = "TC:" + str(TC_Count) + "--" + "Validating Out json file : outlocation has correct output path for " + image + "?" 
            TC_Count += 1
            if pData["outlocation"] == processed_file:
                print string, "PASSED"
            else:
                print string, "FAILED"

            string  = "TC:" + str(TC_Count) + "--" + "Validating Out json file : RESPONSE for " + image + "?" 
            TC_Count += 1

            #print len(pData["response"].split("\n")[1].split(":")[1].strip()) 
            #print len(encl_List[0].strip()) 
           # print len(pData["response"].split("\n"))
            for i in range(1,len(pData["response"].split("\n")) - 1):
                value = pData["response"].split("\n")[i].split(":")[1].strip()
                if value == "NONE":
                    continue 
                if value == encl_List[i-1].strip():
                    print string, "PASSED"
                else:
                    print string, "FAILED"

            
        

if __name__ == '__main__':
    main()
