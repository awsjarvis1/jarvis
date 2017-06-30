#!/usr/bin/python
from loganalysis import loganalytics 


import sys, getopt, tarfile, os, fnmatch

path=""
session=""
intent=""
drives="" #[0_0_1,0_1_3,0_3_4]

def file_to_parse(fname):
    if (fname.endswith(".tar")):
        basedir = os.path.splitext(fname)[0]
        tar = tarfile.open(fname)
        tar.extractall()
        for pattern in ["*.log","*.txt"]:
            for root, dirs, files in os.walk(basedir):
                for name in files:
                    if fnmatch.fnmatch(name, pattern):
                        return os.path.join(basedir,name)
    else:
        return fname

def main(argv):
   inputfile = ''
   outputfile = ''
   drives=""
   opts, args = getopt.getopt(argv,"hp:s:i:d:")
   for opt, arg in opts:
      if opt == '-h':
          print ("test.py -i <inputfile> -o <outputfile>")
          sys.exit()
      elif opt in ("-i"):
          intent = arg
      elif opt in ("-p"):
          path = file_to_parse(arg)
      elif opt in ("-s"):
          session = arg
      elif opt in ("-d"):
          drives = arg
         
   testObj = loganalytics()
   testObj.AnalyzeLog(path,intent,session,drives)


if __name__ == "__main__":
   main(sys.argv[1:])
            


                
                



