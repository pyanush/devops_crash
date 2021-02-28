import re

lotr_in = open("lotr_in.txt", "r")
lotr_out = open("lotr_out.txt", "w")  # or "a" for append

for LOTR in lotr_in:
    if re.findall("ring", LOTR):
        print(LOTR)
        lotr_out.write(LOTR)

lotr_in.close()
lotr_out.close()
