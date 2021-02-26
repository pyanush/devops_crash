import re
import random
file = 'data_gen.csv'
newfile = 'data.csv'
dig='0123456789'
abc='qwertyuiopasdfghjklxcvbnmz'
def host():
    p=[]
    while True:
        if len(p)> 3:
            return p
            break
        ip=int(ggp(3, dig))
        if ip >255 : ip=int(ggp(3, dig))
        else: p.append(str(ip))
def ggp(l,c):
    d=''
    for i in range(l):
      r=random.choice(c)
      d +=r
    return d

def sc():
    a=''
    for x in range (2**8):
        a+=f'{ggp(8, abc)}@{ggp(8, abc)}.{ggp(3, abc)},{ggp(3, dig)}-{ggp(3, dig)}-{ggp(4, dig)},{".".join(host())},https://www.{ggp(8, abc)}.{ggp(4, abc)}.{ggp(3, abc)}\n'
    with open('data_gen.csv', 'a') as file:
        file.write(a)
for x in range (2**8):sc()
def response(reg,nfl):
  with open(nfl+newfile, 'w') as outf:
    with open(file) as inf:
      for line in inf:
        if re.findall(rf'{reg}',line):
          outf.write(''.join(re.findall(rf'{reg}',line))+'\n')
response('\d+\.\d+\.\d+\.\d+','ip_')
response('(\d{3}-\d{3}-\d{4})','phone_')
response('[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}','email_')
response('(https://www\..+)','www_')