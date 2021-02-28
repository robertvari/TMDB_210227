from PySide2.QtCore import QObject, Slot, QUrl
import os

IMAGES_DIR = os.path.dirname(__file__).replace("modules", "images")


class Resources(QObject):
    @Slot(str, result=QUrl)
    def get_image(self, image_name):
        image_path = os.path.join(IMAGES_DIR, image_name)
        return QUrl().fromLocalFile(image_path)