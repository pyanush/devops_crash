# Read the text file, search string using Regular Expression, and write them in new file and STDout
# DevOpsCC lesson 6
import re
import datetime

in_file = open('DemoFile.txt', 'r')
out_file = open('result.log', 'w')
cnt = 0
patt = "(?i)united states"  # pattern that search lines with 'United States'
# results will be add to existing file with session info
time = datetime.datetime.now()
out_file.write('\n' + time.strftime("%d-%m-%Y %H:%M")+' Result for search in session: \n')
out_file.write('\nn.\t#rank\tCompany name\t\t Country\n')

for line in in_file.readlines():
    if not re.search(patt, line):
        cnt += 1
        line = ('#%s\t%s' % (cnt, re.sub('^\t| {2:4}', '', line)))
        print(line, end='')
        out_file.write(line)
