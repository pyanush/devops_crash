import re

input_file = open('lesson6\inputFile.txt',encoding='utf-8')
output_file = open('lesson6\outputFile.txt','w',encoding='utf-8')
for i in input_file:
    if re.findall("group_name", i ):
        print(i)
        output_file.write(i)
input_file.close()
output_file.close()