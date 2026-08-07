import sys
import random
import configparser
from PyQt5.QtWidgets import QApplication, QWidget, QGridLayout, QSizePolicy
from PyQt5.QtGui import QPainter, QColor, QPen, QFont, QBrush, QFontMetrics
from PyQt5.QtCore import Qt, QTimer, QEvent, QRectF, QRect

# --- ЧАСТЬ 1: Виджет выпрыгивающего объекта ---
class AnimatedWordWidget(QWidget):
    def __init__(self, word='A', font_size=34):
        super().__init__()
        self.word = word
        self.font_size = font_size
        
        # Настройки окна
        self.setWindowFlags(Qt.FramelessWindowHint)
        self.setAttribute(Qt.WA_TranslucentBackground)
        
        self.resize(800, 600) 
        self.center_widget()

        # Анимационные параметры
        self.reset_animation_params()

        # Таймер анимации (16 мс ≈ 60 FPS)
        self.timer = QTimer(self)
        self.timer.timeout.connect(self.update_animation)
        
        self._exit_on_esc = True
        self.alpha = 0
        self.is_animating = False
        self.initial_angle = random.uniform(-9, 9)

    def reset_animation_params(self):
        self.frame_count = 0
        self.bounce = 0.0
        self.velocity = -16.5
        self.gravity = 0.8
        self.initial_angle = random.uniform(-9, 9)
        self.alpha = 255

    def center_widget(self):
        screen = QApplication.primaryScreen().geometry()
        size = self.geometry()
        self.move(
            int((screen.width() - size.width()) / 2),
            int((screen.height() - size.height()) / 2)
        )

    def update_animation(self):
        if not self.is_animating:
            return

        self.frame_count += 1
        self.velocity += self.gravity
        self.bounce += self.velocity
        
        decay_rate = 5
        self.alpha -= decay_rate
        
        if self.alpha <= 0:
            self.alpha = 0
            self.is_animating = False
            self.timer.stop()
            # Не закрываем окно сразу, чтобы можно было перезапустить анимацию при активации
            # self.close()
            return

        self.update()

    def start_animation(self):
        """Запускает новую анимацию с текущими параметрами."""
        self.reset_animation_params()
        self.is_animating = True
        self.timer.start(16)
        self.show()

    def paintEvent(self, event):
        painter = QPainter(self)
        painter.setRenderHint(QPainter.Antialiasing)
        rect = self.rect()
        center = rect.center()

        painter.save()
        painter.translate(0, self.bounce)

        painter.translate(center.x(), center.y())
        painter.rotate(self.initial_angle)
        painter.translate(-center.x(), -center.y())

        corner_radius = 15 
        padding = 10 

        font = QFont()
        font.setFamily("Sans Serif")
        font.setPointSize(self.font_size)
        font.setBold(True)
        painter.setFont(font)

        metrics = QFontMetrics(font)
        text_rect_raw = metrics.boundingRect(self.word)

        content_width = text_rect_raw.width() + 2 * padding
        content_height = text_rect_raw.height() + 2 * padding

        target_rect = QRectF(
            center.x() - content_width / 2,
            center.y() - content_height / 2,
            content_width,
            content_height
        )

        # Фон
        bg_base_alpha = 100 
        final_bg_alpha = max(0, int(bg_base_alpha * (self.alpha / 255.0)))
        bg_color = QColor(0, 0, 0, final_bg_alpha)
        brush = QBrush(bg_color)
        painter.setBrush(brush)
        painter.setPen(Qt.NoPen)
        painter.drawRoundedRect(target_rect, corner_radius, corner_radius)

        # Рамка
        frame_base_alpha = 200 
        final_frame_alpha = max(0, int(frame_base_alpha * (self.alpha / 255.0)))
        frame_color = QColor(30, 30, 30, final_frame_alpha)
        pen = QPen(frame_color, 2)
        pen.setJoinStyle(Qt.RoundJoin)
        painter.setPen(pen)
        painter.setBrush(Qt.NoBrush)
        painter.drawRoundedRect(target_rect, corner_radius, corner_radius)

        # Текст
        text_color = QColor("yellow")
        final_text_alpha = max(0, int(255 * (self.alpha / 255.0)))
        text_color.setAlpha(final_text_alpha)
        painter.setPen(text_color)

        text_draw_rect = target_rect.adjusted(padding, padding, -padding, -padding)
        painter.drawText(text_draw_rect, Qt.AlignCenter, self.word)
        painter.restore()


# --- ЧАСТЬ 2: Виджет сетки 4x4 ---
class CircleLabel(QWidget):
    def __init__(self, letter):
        super().__init__()
        self.letter = letter
        self.setSizePolicy(QSizePolicy.Expanding, QSizePolicy.Expanding)

    def paintEvent(self, event):
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


class GridWindow(QWidget): 
    def __init__(self, screen_size): 
        super().__init__()

        self.setGeometry(0, 0, screen_size.width(), screen_size.height())
        
        flags = self.windowFlags()
        self.setWindowFlags(flags | Qt.WindowTransparentForInput | Qt.FramelessWindowHint)
        
        self.setAttribute(Qt.WA_TransparentForMouseEvents, True)
        self.setAttribute(Qt.WA_TranslucentBackground, True)

        grid_layout = QGridLayout()
        grid_layout.setSpacing(20)
        grid_layout.setContentsMargins(20, 20, 20, 20)

        new_letters = ['a', 'r', 's', 't', 'v', 'd', 'c', 'x', 'n', 'e', 'i', 'o', '/', '.', ',', 'h']
        
        idx = 0
        for row in range(4):
            for col in range(4):
                circle_label = CircleLabel(new_letters[idx])
                grid_layout.addWidget(circle_label, row, col)
                idx += 1

        self.setLayout(grid_layout)

        for i in range(4):
            grid_layout.setColumnStretch(i, 1)
            grid_layout.setRowStretch(i, 1)

        self.show()


# --- ГЛАВНЫЙ КОНТРОЛЛЕР ---
class MainController(QWidget):
    def __init__(self):
        super().__init__()
        
        screen = QApplication.primaryScreen()
        self.size = screen.size()

        # При старте определяем режим на основе текущего конфига
        self.load_config_and_set_mode()

        # Перехватываем событие активации приложения
        app = QApplication.instance()
        app.installEventFilter(self)

        # Главное окно скрыто, активные виджеты сами управляют отображением
        self.hide() 

    def load_config_and_set_mode(self):
        config = configparser.ConfigParser()
        try:
            config.read("config.ini")
            self.jump_message = config.get("LettersOverlay", "Message")
        except (configparser.NoSectionError, configparser.NoOptionError):
            print("Config not found or missing key, using default 'TEST'")
            self.jump_message = "TEST"

        # --- ЛОГИКА ВЫБОРА ПО СИТУАЦИИ ---
        # Если Message пустая — показываем сетку 4x4
        # Иначе — запускаем анимацию с текстом
        if self.jump_message.strip() == "":
            print("Message is empty. Launching 4x4 grid mode.")
            # Если виджет уже существует и это сетка — просто убедимся, что он виден
            if not hasattr(self, 'active_widget') or self.mode != "grid":
                if hasattr(self, 'active_widget'):
                    self.active_widget.close()
                self.active_widget = GridWindow(self.size)
            self.mode = "grid"
        else:
            print(f"Message found: '{self.jump_message}'. Launching animated text mode.")
            # Если виджет уже существует, обновляем текст и перезапускаем анимацию
            if hasattr(self, 'active_widget') and isinstance(self.active_widget, AnimatedWordWidget):
                self.active_widget.word = self.jump_message
                self.active_widget.start_animation()
            else:
                if hasattr(self, 'active_widget'):
                    self.active_widget.close()
                self.active_widget = AnimatedWordWidget(self.jump_message, font_size=48)
                self.active_widget.start_animation()
            self.mode = "animated"

    def eventFilter(self, obj, event):
        # Реагируем на активацию приложения
        if event.type() == QEvent.ApplicationActivate:
            # При каждой фокусировке заново читаем конфиг и обновляем режим
            self.load_config_and_set_mode()
        return super().eventFilter(obj, event)


if __name__ == '__main__':
    app = QApplication(sys.argv)
    
    # Установка стиля, чтобы прозрачные окна работали корректно на всех ОС
    app.setStyle("Fusion") 

    controller = MainController()
    
    sys.exit(app.exec_())
