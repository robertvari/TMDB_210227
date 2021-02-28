from PySide2.QtCore import QObject, Slot, QUrl


class Resources(QObject):
    @Slot(str)
    def get_image(self, image_name):
        print(image_name)