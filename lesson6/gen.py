import random
a=[]

abc='qwertyuiopasdfghjklxcvbnmz'
dig='0123456789'
def ggp(l,c):
    d=''
    for i in range(l):
      r=random.choice(c)
      d +=r
    return d

def host():
    p=[]
    while True:
        if len(p)> 3:
            return p
            break
        ip=int(ggp(3, dig))
        if ip >255 : ip=int(ggp(3, dig))
        else: p.append(str(ip))

def gen():a.append(f'{ggp(8, abc)}@{ggp(8, abc)}.{ggp(3, abc)},{ggp(3, dig)}-{ggp(3, dig)}-{ggp(4, dig)},{".".join(host())}\n')
    
with open('data_gen.csv', 'wt') as file:
   for x in range (10000):
       gen()
       file.write(a[x])
      
