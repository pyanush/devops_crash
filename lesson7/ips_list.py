a=[]
inf='logfile.log'
outf='list_ips.csv'
import re, csv
from operator import itemgetter
from collections import Counter

def count(ips_list):
      return Counter(ips_list)
      
def reader(filename):
      with open(filename) as  f:
            log = f.read()
            regexp =  r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'
            ips_list = re.findall(regexp, log)
            return ips_list

def write_csv(counter):
      with open(outf, 'w') as  csvfile:
            writer = csv.writer(csvfile)
            for item in counter:a.append((item, counter[item]))
            for c in Sort_Tuple(a):
                  writer.writerow(c)
                  print(c)

def Sort_Tuple(tup):  
      lst = len(tup)  
      for i in range(0, lst):  
            for j in range(0, lst-i-1):  
                  if (tup[j][1] > tup[j + 1][1]):  
                      temp = tup[j]  
                      tup[j]= tup[j + 1]  
                      tup[j + 1]= temp  
      return tup

if __name__ == '__main__':
      write_csv(count(reader(inf)))
