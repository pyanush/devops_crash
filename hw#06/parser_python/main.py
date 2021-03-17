import re
#Feb 15 13:01:58 vmi526857 sshd[566]: error: maximum authentication attempts exceeded for root from 218.92.0.172 port 39883 ssh2 [preauth]



def run(file):
    print(f'FILE: {file}')
    # months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
    file = open(file=file, mode='r', encoding='utf-8')
    number_str = 0
    for line in file:
        # print(line, end="")
        # part1 = re.findall(r"^\w{3}\s\d{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2}\s\w+\s[a-zA-Z-]+\[?\w+\]?\:", line)
        # print(f"part1: {part1}")
        # part2 = re.findall(r"^\w{3}\s\w+\s[0-9:]+\s\w+\s[a-zA-Z-]+\[?\w+\]?\:.+$", line)
        part2 = re.findall(r"\s[a-zA-Z-]+\[?\w+\]?\:.+$", line)
        print(f"part2: {part2}")
        # month = re.findall(r"^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)", line)
        # day = re.findall(r"\s[0-9]{2}\s", line)
        # time = re.findall(r"[0-9]{2}\:[0-9]{2}\:[0-9]{2}", line)
        # host = re.findall(r"(?<=\:[0-9]{2}\s)[a-zA-Z]+[0-9]+", line)
        # service = re.findall(r"[-a-z]+\[[0-9]+\]", line)
        # ip = re.findall(r"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}", line)
        # # msg = re.findall(r"(?<=\]\:)\[\w*\]", line)
        # print(f"->MONTH: {month}, DAY: {day}, TIME: {time}, HOSTNAME: {host}, SERVICE: {service}, IP: {ip}")
        # # print(f"MSG: {msg}")
        number_str += 1
    print(f"\nnumber_str = {number_str}")
    file.close()

if __name__ == '__main__':
    run('logfile/test.log')
    # STR = "Feb 15 13:01:58 vmi526857 sshd[566]: error: maximum authentication attempts exceeded for root from 218.92.0.172 port 39883 ssh2 [preauth]\n"
    # run(STR)

