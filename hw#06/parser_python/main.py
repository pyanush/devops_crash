import re

def run(file):
    print(f'FILE: {file}')
    file = open(file=file, mode='r', encoding='utf-8')
    number_str = 0
    for line in file:
        number_str += 1
        print(f"str[{number_str}]-> {line}", end="")
        split = re.findall(r"(\w{3}\s\d{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2}\s\w+\s[a-zA-Z-]+\[?\w+?\]?)\:\s(.+$)", line)
        part = split[0]
        # print(f"part: {part}")
        # print(f"part0: {part[0]}")
        # print(f"part1: {part[1]}")
        split1 = re.findall(r"^(\w{3})\s([0-9]{2})\s([0-9]{2}\:[0-9]{2}\:[0-9]{2})\s([a-zA-Z]+[0-9]+)\s([a-zA-Z-].+)", part[0])
        part1_1 = split1[0]
        # print(f"split1: {part1_1}")
        month = part1_1[0]
        day = part1_1[1]
        time = part1_1[2]
        host = part1_1[3]
        service = part1_1[4]
        ip = re.findall(r"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}", part[1])
        msg = part[1]
        print(f"MONTH: {month}, DAY: {day}, TIME: {time}, HOSTNAME: {host}, SERVICE: {service}, IP: {ip}")
        print(f"MSG: {msg}")
        print("----------------------------------------------------------------------------")
    file.close()

if __name__ == '__main__':
    run('logfile/test.log')

