# Этот скрипт предполагает наличие ярлыка браузера типа chromium - browser.lnk. Браузер должен принимать такие аргументы запуска, как "--kiosk" и "--new-window". Для полноценного использования также рекомендую установить расширения vimium и "New tab, new window".

import win32gui, win32con
import os

prompt = input("Введите запрос: ")

program = win32gui.GetForegroundWindow()
win32gui.ShowWindow(program, win32con.SW_HIDE)


if "." in prompt:
    os.system("browser.lnk --kiosk --new-window \""+prompt+"\"")
elif prompt[:3] == "yt ":
    os.system("browser.lnk --kiosk --new-window \"https://youtube.com/results?search_query="+prompt[3:].replace(" ", "+")+"\"")
elif prompt[:3] in ["tr ", "тр "]:
    if prompt[4].lower() in "абвгдеёжзийклмнопрстуфхцчшщъыьэюя":
        os.system("browser.lnk --kiosk --new-window \"https://translate.yandex.ru/?source_lang=ru&target_lang=en&text="+prompt[3:].replace(" ", "+")+"\"")
    else:
        os.system("browser.lnk --kiosk --new-window \"https://translate.yandex.ru/?source_lang=en&target_lang=ru&text="+prompt[3:].replace(" ", "+")+"\"")

else:
    os.system("browser.lnk --kiosk --new-window \"https://google.com/search?q="+prompt.replace(" ", "+")+"\"")
quit()

