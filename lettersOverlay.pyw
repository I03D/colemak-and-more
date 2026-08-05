
from PyQt5.QtWidgets import QApplication, QGridLayout, QWidget, QSizePolicy
from PyQt5.QtCore import Qt, QRect, QEvent
from PyQt5.QtGui import QPainter, QColor, QPen
import sys

class CircleLabel(QWidget):
    def __init__(self, letter):
        super().__init__()
        self.letter = letter
        self.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

    def paintEvent(self, event):
        # ГЛАВНОЕ ИЗМЕНЕНИЕ: Если родительское окно минимизировано, ничего не рисуем
        if self.parent() and self.parent().isMinimized():
            return

        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)

        rect = self.rect()
        diameter = int(min(rect.width(), rect.height()) * 0.3)

        x = (rect.width() - diameter) // 2
        y = (rect.height() - diameter) // 2
        circle_rect = QRect(x, y, diameter, diameter)

        bg_color = QColor(0, 0, 0, 75)
        painter.setBrush(bg_color)
        painter.setPen(QPen(QColor(0, 0, 0, 125), 2))

        painter.drawEllipse(circle_rect)

        font = painter.font()
        font.setBold(True)
        font_size = 34
        font.setPointSize(font_size)
        painter.setFont(font)

        painter.setPen(QColor("yellow"))
        painter.drawText(circle_rect, Qt.AlignCenter, self.letter)


class Window(QWidget): 
    def __init__(self, screen_size): 
        super().__init__()
        
        # Устанавливаем геометрию на весь экран
        self.setGeometry(0, 0, screen_size.width(), screen_size.height())
        
        flags = self.windowFlags()
        # Добавляем флаги: прозрачное для ввода, без рамки, инструмент, изначально минимизировано
        self.setWindowFlags(flags | Qt.WindowTransparentForInput | Qt.FramelessWindowHint | Qt.Tool | Qt.WindowMinimized)
        
        self.setAttribute(Qt.WA_TransparentForMouseEvents, True)
        self.setAttribute(Qt.WA_TranslucentBackground, True)

        grid_layout = QGridLayout()
        grid_layout.setSpacing(20)
        grid_layout.setContentsMargins(20, 20, 20, 20)

        new_letters = ['a', 'r', 's', 't', 'v', 'd', 'c', 'x', 'n', 'e', 'i', 'o', '/', '.', ',', 'h']
        
        idx = -1
        for row in range(4):
            for col in range(4):
                idx += 1
                circle_label = CircleLabel(new_letters[idx])
                grid_layout.addWidget(circle_label, row, col)

        self.setLayout(grid_layout)

        for i in range(4):
            grid_layout.setColumnStretch(i, 1)
            grid_layout.setRowStretch(i, 1)

        # Сначала показываем, потом сразу сворачиваем (чтобы корректно применились флаги)
        self.show()
        self.showMinimized()

    # Этот метод вызывается при ЛЮБОМ изменении состояния окна (свернуть, развернуть, закрыть и т.д.)
    def changeEvent(self, event):
        if event.type() == QEvent.WindowStateChange:
            # Если окно больше не минимизировано -> принудительно обновляем отрисовку всех дочерних виджетов
            if not self.isMinimized():
                self.update() 
                # Также можно вызвать update() у каждого виджета отдельно, но update() родителя обычно достаточно
        super().changeEvent(event)

if __name__ == '__main__':
    app = QApplication(sys.argv) 
    screen = app.primaryScreen()
    size = screen.size()

    window = Window(size)
    
    # Явное установка минимизированного состояния (дублирует логику в __init__, но для надежности)
    window.setWindowState(window.windowState() | Qt.WindowMinimized)
    window.setWindowTitle("lettersOverlay.pyw")
    
    sys.exit(app.exec_())
