import re
#Feb 15 13:01:58 vmi526857 sshd[566]: error: maximum authentication attempts exceeded for root from 218.92.0.172 port 39883 ssh2 [preauth]



def run(file):
    print(f'FILE: {file}')
    months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
    month = re.findall(r"\bFeb\b", STR)
    print(f"MONTH: {month}")


    # file = open(file=file, mode='r', encoding='utf-8')
    # number_str = 0
    # for line in file:
    #     print(line, end="")
    #     month = re.findall(r"\bFeb\b", line)
    #     print(f"MONTH: {month}")
    #     number_str += 1
    # print(f"\nnumber_str = {number_str}")
    # file.close()

if __name__ == '__main__':
    # run('logfile/test.log')
    STR = "Feb 15 13:01:58 vmi526857 sshd[566]: error: maximum authentication attempts exceeded for root from 218.92.0.172 port 39883 ssh2 [preauth]"
    run(STR)

