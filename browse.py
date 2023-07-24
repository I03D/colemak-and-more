import os
prompt = input("Введите запрос: ")
os.system("chrome.exe.lnk google.com/search?q="+prompt.replace(" ", "+"))
