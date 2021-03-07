import re

inp_file = open ('input_file.txt', 'rt', encoding="utf8")
outp_file = open ('output_file.txt', 'wt', encoding="utf8")

for row in inp_file:
    x = re.search('\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}[0-9]', row)
    if x:
        outp_file.write(x.string)

outp_file.close()

