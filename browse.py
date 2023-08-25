# Этот скрипт предполагает наличие ярлыка браузера типа chromium - browser.lnk. Браузер должен принимать такие аргументы запуска, как "--kiosk" и "--new-window". Для полноценного использования также рекомендую установить расширения vimium и "New tab, new window".

import win32gui, win32con
import os

prompt = input("Введите запрос: ")

program = win32gui.GetForegroundWindow()
win32gui.ShowWindow(program, win32con.SW_HIDE)

os.system("browser.lnk --kiosk --new-window \"google.com/search?q="+prompt.replace(" ", "+")+"\"")

quit()

