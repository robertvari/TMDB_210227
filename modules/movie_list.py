from PySide2.QtCore import QAbstractListModel, QModelIndex, Qt
import tmdbsimple as tmdb
from dotenv import load_dotenv
from utilities import settings
import os

ENV_PATH = os.path.join(settings.APP_ROOT, ".env")
load_dotenv(ENV_PATH)
tmdb.API_KEY = os.getenv('TMDB_API_KEY')


class MovieList(QAbstractListModel):
    DataRole = Qt.UserRole

    def __init__(self):
        super(MovieList, self).__init__()
        self.items = []
        self.current_page = 1
        self.movie = tmdb.Movies()

        self._fetch()

    def _fetch(self):
        result = self.movie.popular(page=self.current_page)

        for i in result["results"]:
            self.insert_movie(self._serialized(i))

        pass

    def _serialized(self, movie_data):
        def get_vote_average():
            if not movie_data.get("vote_average"):
                return 0
            return int(movie_data.get("vote_average") * 10)

        return {
            "title": movie_data.get("title"),
            "release_date": movie_data.get("release_date"),
            "vote_average": get_vote_average(),
            "poster_path": movie_data.get("poster_path")
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


if __name__ == '__main__':
    movie_list = MovieList()