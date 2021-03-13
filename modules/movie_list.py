from PySide2.QtCore import QAbstractListModel
import tmdbsimple as tmdb
from dotenv import load_dotenv
from utilities import settings
import os

ENV_PATH = os.path.join(settings.APP_ROOT, ".env")
load_dotenv(ENV_PATH)
tmdb.API_KEY = os.getenv('TMDB_API_KEY')


class MovieList(QAbstractListModel):
    def __init__(self):
        super(MovieList, self).__init__()
        self.movie = tmdb.Movies()

        self._fetch()

    def _fetch(self):
        result = self.movie.popular()

        for i in result["results"]:
            print(i)


if __name__ == '__main__':
    movie_list = MovieList()