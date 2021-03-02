import re

# For Email's
pattern_1 = re.compile('[\w\.-]+@[\w\.-]+(\.[\w]+)+')
# For IP addr
pattern_2 = re.compile('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}[^0-9]')

input_file = open('input.txt', 'r')
output_file = open('output.txt', 'a')

for line in input_file:
    result = pattern_2.search(line)
    if result:
        print(line)
        output_file.write(line)



# working part
#
#for line in input_file:
#    result = re.search('[\w\.-]+@[\w\.-]+(\.[\w]+)+', line)
#    if result:
#        print(line)
#        output_file.write(line)
#
# for Email's
# [\w\.-]+@[\w\.-]+(\.[\w]+)+
#
# for IP addr
#\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}[^0-9]