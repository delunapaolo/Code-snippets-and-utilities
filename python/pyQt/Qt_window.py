from PyQt5 import QtCore, QtWidgets


class Qt_window(QtWidgets.QMainWindow):
    resized = QtCore.pyqtSignal()
    about_to_close = QtCore.pyqtSignal()

    def __init__(self):
        super(Qt_window, self).__init__()
        self.allowed_to_close = False

    def resizeEvent(self, event):
        """Called whenever the window is resized."""
        self.resized.emit()
        return super(Qt_window, self).resizeEvent(event)

    def closeEvent(self, event):
        """Called whenever the window receives the close command. We only proceed
        if we are allowed to do so."""
        self.about_to_close.emit()
        if self.allowed_to_close:
            event.accept()
            super(Qt_window, self).closeEvent(event)
        else:
            event.ignore()

