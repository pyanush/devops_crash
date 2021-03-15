import re

# open for read and write(append mode) txt files
input_file_text = open ("text_lesson1_py.txt", "r")
output_file_text = open ("output_result.txt", "at")

# read line by line and check if line include IP adress - true and 
# then write to stdout and in file this line
for line in input_file_text.readlines() :
    if re.search("\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}", line) :
        print(line.replace('\n','\r'))
        output_file_text.write(line)

