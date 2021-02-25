import os
import time
import sys

fld=os.path.join(os.path.expanduser("~"),"upload", "users")
print fld
def hello(b, c, d):
    for i in range (1, int(c)+1):
        os.mkdir(b+str(i), int(d))

if __name__ == "__main__":
    a = (sys.argv[1])[1:]
    b = (sys.argv[2])
    c = (sys.argv[3])
    d = (sys.argv[4])
    os.mkdir(a)
    os.chdir(a)
    print 'folders created'
    #os.rmdir()
    hello(b, c, d)
time.sleep(5)
