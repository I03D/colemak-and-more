# Этот скрипт предполагает наличие ярлыка Chrome - chrome.exe (chrome.exe.lnk)
import os
prompt = input("Введите запрос: ")
os.system("chrome.exe.lnk --new-window google.com/search?q="+prompt.replace(" ", "+"))
