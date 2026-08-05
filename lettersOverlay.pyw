from PyQt5.QtWidgets import QApplication, QGridLayout, QWidget, QSizePolicy
from PyQt5.QtCore import Qt, QRect
from PyQt5.QtGui import QPainter, QColor, QPen
import sys

# Виджет, который рисует круг и текст внутри него
class CircleLabel(QWidget):
    def __init__(self, letter):
        super().__init__()

        self.letter = letter
        # Разрешаем растягиваться в клетке сетки
        self.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)  # Сглаживание краёв

        rect = self.rect()
        # Вычисляем максимально вписывающийся в клетку круг (строго квадратный)
        diameter = int(min(rect.width(), rect.height()) * 0.3)

        x = (rect.width() - diameter) // 2
        y = (rect.height() - diameter) // 2
        circle_rect = QRect(x, y, diameter, diameter)

        # Полупрозрачный чёрный фон внутри круга и тонкая обводка круга
        bg_color = QColor(0, 0, 0, 75)
        painter.setBrush(bg_color)
        painter.setPen(QPen(QColor(0, 0, 0, 125), 2))

        # Рисуем строго круг внутри клетки
        painter.drawEllipse(circle_rect)

        # Центрируем букву внутри круга и масштабируем размер шрифта под размер круга
        font = painter.font()
        font.setBold(True)
        # Размер шрифта пропорционален диаметру круга
        font_size = 34
        font.setPointSize(font_size)
        painter.setFont(font)

        painter.setPen(QColor("yellow"))
        painter.drawText(circle_rect, Qt.AlignCenter, self.letter)


class Window(QWidget): 
    def __init__(self, screen_size): 
        super().__init__()
        self.setGeometry(0, 0, screen_size.width(), screen_size.height())
        
        flags = self.windowFlags()
        self.setWindowFlags(flags | Qt.WindowTransparentForInput | Qt.FramelessWindowHint | Qt.Tool | Qt.WindowMinimized)
        
        self.setAttribute(Qt.WA_TransparentForMouseEvents, True)
        self.setAttribute(Qt.WA_TranslucentBackground, True)

        grid_layout = QGridLayout()
        grid_layout.setSpacing(20)
        grid_layout.setContentsMargins(20, 20, 20, 20)

        # Новый список букв для замены
        new_letters = ['a', 'r', 's', 't', 'v', 'd', 'c', 'x', 'n', 'e', 'i', 'o', '/', '.', ',', 'h']
        
        idx = -1
        for row in range(4):
            for col in range(4):
                idx += 1
                print(idx)
                circle_label = CircleLabel(new_letters[idx])
                grid_layout.addWidget(circle_label, row, col)

        self.setLayout(grid_layout)

        # Равномерное распределение по сетке: каждой строке/колонке — одинаковый вес
        for i in range(4):
            grid_layout.setColumnStretch(i, 1)
            grid_layout.setRowStretch(i, 1)

        self.showMinimized()
        QTimer.singleShot(0, window.showMinimized)  # затем минимизируем после старта цикла

  
if __name__ == '__main__':
    app = QApplication(sys.argv) 
    screen = app.primaryScreen()
    size = screen.size()

    window = Window(size)
    window.setWindowState(Qt.WindowMinimized)
    window.setWindowTitle("lettersOverlay.pyw")  # <-- установка заголовка
    sys.exit(app.exec_())
