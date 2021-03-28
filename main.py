# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine

from modules.resource_loader import Resources
from modules.movie_list import MovieList, MovieListProxy
from modules.movie_details import Movie


class MovieDB:
    def __init__(self):
        self.app = QGuiApplication(sys.argv)
        self.engine = QQmlApplicationEngine()
        self.context = self.engine.rootContext()

        self.resource_loader = Resources()
        self.context.setContextProperty("Resources", self.resource_loader)

        self.movie_list = MovieList()
        self.context.setContextProperty("MovieList", self.movie_list)

        self.movie_list_proxy = MovieListProxy()
        self.movie_list_proxy.setSourceModel(self.movie_list)
        self.context.setContextProperty("MovieListProxy", self.movie_list_proxy)

        self.movie = Movie()
        self.context.setContextProperty("Movie", self.movie)

        self.engine.load(os.path.join(os.path.dirname(__file__), "main.qml"))

        if not self.engine.rootObjects():
            sys.exit(-1)

        self.app.lastWindowClosed.connect(self._close_app)

        sys.exit(self.app.exec_())

    def _close_app(self):
        if self.movie_list.download_worker and self.movie_list.download_worker.is_working:
            self.movie_list.download_worker.stop_download()


if __name__ == "__main__":
    MovieDB()