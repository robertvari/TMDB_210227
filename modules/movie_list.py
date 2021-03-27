from PySide2.QtCore import QAbstractListModel, QModelIndex, Qt, QUrl, \
    QRunnable, QObject, Signal, QThreadPool, Property
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
    movie_list_changed = Signal()
    download_started = Signal()
    download_progress_changed = Signal()

    def __init__(self):
        super(MovieList, self).__init__()
        self.items = []
        self._is_downloading = False
        self._max_pages = 1

        self.pool = QThreadPool()
        self.pool.setMaxThreadCount(1)

        self._fetch()

    def _fetch(self):
        worker = MovieListWorker(self._max_pages)
        worker.signals.download_process_started.connect(self._downloading_started)
        worker.signals.movie_data_downloaded.connect(self.process_move_data)
        worker.signals.download_process_finished.connect(self._downloading_finished)

        self.pool.start(worker)

    def _downloading_started(self):
        self._is_downloading = True
        self.download_started.emit()
        self.download_progress_changed.emit()

    def _downloading_finished(self):
        self._is_downloading = False
        self.download_progress_changed.emit()

    def process_move_data(self, movie_data):
        self.insert_movie(self._serialized(movie_data))

    def _serialized(self, movie_data):
        def get_vote_average():
            return int(movie_data.get("vote_average") * 10)

        return {
            "title": movie_data.get("title"),
            "release_date": movie_data.get("release_date"),
            "vote_average": get_vote_average(),
            "poster": QUrl().fromLocalFile(movie_data["local_poster"]),
            "id": movie_data["id"]
        }

    def insert_movie(self, movie_data):
        self.beginInsertRows(QModelIndex(), self.rowCount(), self.rowCount())
        self.items.append(movie_data)
        self.movie_list_changed.emit()
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

    def _get_movie_count(self):
        return len(self.items)

    def _get_max_download_count(self):
        return self._max_pages * 20

    def _get_is_downloading(self):
        return self._is_downloading

    movie_count = Property(int, _get_movie_count, notify=movie_list_changed)
    max_download_count = Property(int, _get_max_download_count, notify=download_started)
    is_downloading = Property(bool, _get_is_downloading, notify=download_progress_changed)


class WorkerSignals(QObject):
    movie_data_downloaded = Signal(dict)
    download_process_started = Signal()
    download_process_finished = Signal()

    def __init__(self):
        super(WorkerSignals, self).__init__()


class MovieListWorker(QRunnable):
    def __init__(self, max_pages):
        super(MovieListWorker, self).__init__()
        self.signals = WorkerSignals()
        self.movie = tmdb.Movies()
        self.max_pages = max_pages

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
        self.signals.download_process_started.emit()

        if not os.path.exists(settings.CACHE_FOLDER):
            os.makedirs(settings.CACHE_FOLDER)

        current_page = 1

        while current_page <= self.max_pages:
            result = self.movie.popular(page=current_page)
            for movie_data in result["results"]:
                if not self._check_movie(movie_data):
                    continue

                movie_data["local_poster"] = download_image(movie_data["poster_path"])
                self.signals.movie_data_downloaded.emit(movie_data)

            current_page += 1

        # emit all progress finished signal!
        self.signals.download_process_started.emit()

    def run(self):
        self._cache_data()


if __name__ == '__main__':
    movie_list = MovieList()