from PySide2.QtCore import QAbstractListModel, QModelIndex, Qt, QUrl, \
    QRunnable, QObject, Signal, QThreadPool
import tmdbsimple as tmdb
from dotenv import load_dotenv
from utilities import settings
from utilities.downloader import download_image
import os, time

ENV_PATH = os.path.join(settings.APP_ROOT, ".env")
load_dotenv(ENV_PATH)
tmdb.API_KEY = os.getenv('TMDB_API_KEY')


class MovieList(QAbstractListModel):
    DataRole = Qt.UserRole

    def __init__(self):
        super(MovieList, self).__init__()
        self.items = []

        self.pool = QThreadPool()
        self.pool.setMaxThreadCount(1)

        self._fetch()

    def _fetch(self):
        worker = MovieListWorker()
        worker.signals.finished.connect(self.process_move_data)
        self.pool.start(worker)

    def process_move_data(self, movie_data):
        self.insert_movie(self._serialized(movie_data))

    def _serialized(self, movie_data):
        def get_vote_average():
            return int(movie_data.get("vote_average") * 10)

        return {
            "title": movie_data.get("title"),
            "release_date": movie_data.get("release_date"),
            "vote_average": get_vote_average(),
            "poster": QUrl().fromLocalFile(movie_data["local_poster"])
        }

    def insert_movie(self, movie_data):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.items.append(movie_data)
        self.endInsertRows()

    def rowCount(self, parent=QModelIndex):
        return len(self.items)

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        if role == MovieList.DataRole:
            return self.items[row]

    def roleNames(self):
        return {
            MovieList.DataRole: b'movie_item'
        }


class WorkerSignals(QObject):
    finished = Signal(dict)

    def __init__(self):
        super(WorkerSignals, self).__init__()


class MovieListWorker(QRunnable):
    def __init__(self):
        super(MovieListWorker, self).__init__()
        self.signals = WorkerSignals()
        self.movie = tmdb.Movies()

    def _check_movie(self, movie_data):
        if not movie_data.get("poster_path"):
            return False

        if not movie_data.get("vote_average"):
            return False

        if not movie_data.get("backdrop_path"):
            return False

        if not movie_data.get("release_date"):
            return False

        return True

    def _cache_data(self):
        if not os.path.exists(settings.CACHE_FOLDER):
            os.makedirs(settings.CACHE_FOLDER)

        result = self.movie.popular(page=1)
        for movie_data in result["results"]:
            if not self._check_movie(movie_data):
                continue

            movie_data["local_poster"] = download_image(movie_data["poster_path"])
            self.signals.finished.emit(movie_data)

    def run(self):
        self._cache_data()


if __name__ == '__main__':
    movie_list = MovieList()