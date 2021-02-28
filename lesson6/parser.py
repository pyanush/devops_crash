# Find string with case insensitive key
import re

inputFile = open("input.txt", "r")
outputFile = open("ouput.txt", "w")
count = 0

for line in inputFile:
    count += 1
    if re.findall("(?i)china", line):
        print(line)
        outputFile.write(line)

inputFile.close()
outputFile.close()
