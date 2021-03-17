import re

file_name = "basefile.txt"
result_file_name = "resultfile.txt"
my_file = open(file_name, mode="r", encoding="UTF-8", )
results_file_read = open(result_file_name, mode="w", encoding="UTF-8")

my_text = my_file.read()
seekstring = r"[0-3]\d\.[0-1]\d\.\d{4}"

results = re.findall(seekstring, my_text)

for datephrase in results:
    print(datephrase)
    results_file_read.write(datephrase + "\n")
print("Total: " + str(len(results)))