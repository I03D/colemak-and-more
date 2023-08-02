import os
prompt = input("Введите запрос: ")
os.system("chrome.exe.lnk --new-window google.com/search?q="+prompt.replace(" ", "+"))
