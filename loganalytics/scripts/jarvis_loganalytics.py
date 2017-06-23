#!/usr/bin/python
from loganalysis import loganalytics 


import sys, getopt

path=""
session=""
intent=""

def main(argv):
   inputfile = ''
   outputfile = ''
   opts, args = getopt.getopt(argv,"hp:s:i:")
   for opt, arg in opts:
      if opt == '-h':
         print ("test.py -i <inputfile> -o <outputfile>")
         sys.exit()
      elif opt in ("-i"):
         intent = arg
      elif opt in ("-p"):
         path = arg
      elif opt in ("-s"):
         session = arg
     
   testObj = loganalytics()
   testObj.AnalyzeLog(path,intent,session)


if __name__ == "__main__":
   main(sys.argv[1:])
            


                
                



