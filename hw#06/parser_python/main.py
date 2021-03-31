import re
import pandas as pd

PATH = 'logfile/test.log'


def start(path):
    with open(file=path, mode='r', encoding='utf-8') as logfile:
        number_str = 0
        for line in logfile:
            number_str += 1
            parser_list = parser_regexp(line)
            convert_to_exl(parser_list, number_str)
            # print(parser_list, end="\n")


def convert_to_exl(log_list, n):
    print(log_list)
    date = str(2021)+"-"+str(log_list[0])+"-"+str(log_list[1])+" "+str(log_list[2])
    host = log_list[3]
    srv = log_list[4]
    ip = log_list[5]
    msg = log_list[6]
    df = pd.DataFrame({"number": n, "date_time": date, "hostname": host, "service": srv, "ip_address": ip, "message": msg})
    df.to_excel("./log.xls", index=False)

def parser_regexp(logfile_str):
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    split = re.findall(r"(\w{3}\s\d{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2}\s\w+\s[a-zA-Z-]+\[?\w+?\]?)\:\s(.+$)", logfile_str)
    part = split[0]
    split1 = re.findall(
        r"^(\w{3})\s([0-9]{2})\s([0-9]{2}\:[0-9]{2}\:[0-9]{2})\s([a-zA-Z]+[0-9]+)\s([a-zA-Z-].+)", part[0])
    part1_1 = split1[0]
    #
    month = months.index(part1_1[0])
    day = part1_1[1]
    time = part1_1[2]
    host = part1_1[3]
    service = part1_1[4]
    ip = re.findall(r"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}", part[1])
    msg = part[1]
    #
    res_lst = [month, day, time, host, service, ip, msg]
    return res_lst


if __name__ == '__main__':
    start(PATH)
