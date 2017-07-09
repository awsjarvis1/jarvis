import sys

def createJSON(filePath):
	fileArr = filePath.split(".")
	absFilePath = fileArr[0] + "_response.json"
	print absFilePath
	
	try:
		file = open(absFilePath, 'r')
	except IOError:
		file = open(absFilePath, 'w')
	
	with open(absFilePath, "w") as text_file:
		text_file.write("{'key':'value'}")



if __name__=="__main__":
	
	#print time when the dumping of json into postgres db starts

	print 'Start time PASSED' 
	
	static_dir_path = sys.argv[1]
	
	print 'Print the arg ' + static_dir_path + ' PASSED'

	
	createJSON(static_dir_path)
	
	#print the time after the json has been dumped into postgres db

	print 'End time PASSED'

