import re
import os
import sys
import openpyxl

PATH = 'logfile/test.log'

def start(path):
    # Создаем xls файл с заголовками полей
    xls_report = openpyxl.Workbook()
    xls_report["Sheet"].title = "ReportLog"
    sh_report = xls_report.active
    sh_report["A1"] = "str#"
    sh_report["B1"] = "date_time"
    sh_report["C1"] = "hostname"
    sh_report["D1"] = "service"
    sh_report["E1"] = "ip_address"
    sh_report["F1"] = "message"
    with open(file=path, mode='r', encoding='utf-8') as logfile:
        n = 0
        for line in logfile:
            n += 1
            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            # Парсим данные
            split = re.findall(r"(\w{3}\s\d{2}\s[0-9]{2}\:[0-9]{2}\:[0-9]{2}\s\w+\s[a-zA-Z-]+\[?\w+?\]?)\:\s(.+$)",line)
            part = split[0]
            split1 = re.findall(
                r"^(\w{3})\s([0-9]{2})\s([0-9]{2}\:[0-9]{2}\:[0-9]{2})\s([a-zA-Z]+[0-9]+)\s([a-zA-Z-].+)", part[0])
            part1_1 = split1[0]
            # Раскидываем роспарсенные данные в переменные
            month = str(months.index(part1_1[0]) + 1)
            month = month if len(month) == 2 else "0" + month
            day = part1_1[1]
            time = part1_1[2]
            host = part1_1[3]
            service = part1_1[4]
            ip = "".join(re.findall(r"[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}", part[1]))
            msg = part[1]
            date = str(2021) + "-" + month + "-" + day + " " + time
            # Собираем результат в список
            result = [date, host, service, ip, msg]
            print(result)
            # Добавляем данные в xls файл
            sh_report[n + 1][0].value = n           # str#
            sh_report[n + 1][1].value = result[0]   # date_time
            sh_report[n + 1][2].value = result[1]   # hostname
            sh_report[n + 1][3].value = result[2]   # service
            sh_report[n + 1][4].value = result[3]   # ip_address
            sh_report[n + 1][5].value = result[4]   # message
            xls_report.save("report.xls")

if __name__ == '__main__':
    if os.path.isfile(PATH):
        print("OK!")
        start(PATH)
    else:
        print("Лог-файл не существует! Введите правильный путь к лог-файлу!")
        sys.exit()

