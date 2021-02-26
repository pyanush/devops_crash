import re,os
file = 'data.csv'
newfile = 'newdata.csv'
line = ""

def writefile(a):
        f = open(a+newfile, 'w')
        f.write(line)
        print (line ,"File written")
        f.close()
        
if os.path.exists(file):
        data = open(file,'r')
        readline = data.read()
else:
        print ("File not found")
        raise SystemExit

def response(reg,fl):
      global line
      line = ""
      r = re.compile(rf'{reg}')
      res = r.findall(readline)
      for x in res:
              line += str(x)+"\n"
      writefile(fl)

response('(http://www\..+)','www_')
response('(\d{3}-\d{3}-\d{4})','phone_')
response('(\d{5})','zip_')
response('[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}','email_')
