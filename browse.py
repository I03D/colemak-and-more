# Этот скрипт предполагает наличие ярлыка Chrome - chrome.exe (chrome.exe.lnk)

import win32gui, win32con
import os

prompt = input("Введите запрос: ")

program = win32gui.GetForegroundWindow()
win32gui.ShowWindow(program, win32con.SW_HIDE)

os.system("browser.lnk --kiosk --new-window \"google.com/search?q="+prompt.replace(" ", "+")+"\"")

quit()

