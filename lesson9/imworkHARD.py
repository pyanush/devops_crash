import time, datetime
i=0
while i<20:
    time.sleep(1)
    print(str(datetime.datetime.now().strftime("%H:%M:%S")))
    i+=1
