# download assignment 2 data files using

import urllib


# download sample code
sampleCodeURL = "http://vgc.poly.edu/projects/gx5003-fall2014/week2/lab/data/sample_code.py"
codeFile = urllib.URLopener()
codeFile.retrieve(sampleCodeURL, "sample_code.py")

# download csv file with database
csvURL = "http://vgc.poly.edu/projects/gx5003-fall2014/week2/lab/data/NYC_Jobs_sample.csv"
csvfile = urllib.URLopener()
csvfile.retrieve(csvURL, "NYC_Jobs_sample.csv")

# download input and output files for problems 1-6
fileNamePrefix = "sample_data_problem_"

filePath = "http://vgc.poly.edu/projects/gx5003-fall2014/week2/lab/data/"
inputFilePrefix = "sample_data_problem_"
outputFilePrefix = "sample_output_problem_"


for x in range(1, 7):
    inputFileName = inputFilePrefix + str(x) + ".txt"
    inputFileURL = filePath + inputFileName

    outputFileName = outputFilePrefix + str(x) + ".txt"
    outputFileURL = filePath + outputFileName
 
    testfile = urllib.URLopener()
    testfile.retrieve(inputFileURL, inputFileName)
    testfile = urllib.URLopener()
    testfile.retrieve(outputFileURL, outputFileName)

