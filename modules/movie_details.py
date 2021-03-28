from PySide2.QtCore import QObject, Slot, QUrl, Property, Signal
from utilities import settings
import os
from datetime import datetime, timedelta
import tmdbsimple as tmdb
from dotenv import load_dotenv
from utilities.downloader import download_image

ENV_PATH = os.path.join(settings.APP_ROOT, ".env")
load_dotenv(ENV_PATH)
tmdb.API_KEY = os.getenv('TMDB_API_KEY')


class Movie(QObject):
    movie_loaded = Signal()

    def __init__(self):
        super(Movie, self).__init__()
        self._title = None
        self._tagline = None
        self._poster = None
        self._backdrop = None
        self._overview = None
        self._release_date = None
        self._runtime = None
        self._vote_average = None
        self._original_language = None
        self._genres = None


    @Slot(int)
    def set_movie(self, movie_id):
        movie = tmdb.Movies(movie_id)
        response = movie.info()

        def get_genres():
            if not response.get("genres"):
                return ""

            return ", ".join([i["name"] for i in response.get("genres")])

        def get_runtime():
            if not response.get("runtime"):
                return ""

            tdelta = timedelta(seconds=response.get("runtime"))
            d, h, m = str(tdelta).split(":")

            h = int(h)
            m = int(m)

            return f"{h}h {m}m"

        self._title = response.get("title")
        self._tagline = response.get("tagline")
        self._poster = self._get_poster_path(response.get("poster_path"))
        self._backdrop = self._get_backdrop_path(response.get('backdrop_path'))
        self._overview = response.get("overview")
        self._release_date = self._convert_date(response.get("release_date"))
        self._runtime = get_runtime()
        self._vote_average = int(response.get("vote_average") * 10)
        self._original_language = response.get("original_language")
        self._genres = get_genres()

        self.movie_loaded.emit()

    def _get_poster_path(self, poster_url):
        cache_folder = settings.CACHE_FOLDER
        file_name = poster_url[1:]

        local_path = os.path.join(cache_folder, file_name)
        if not os.path.exists(local_path):
            local_path = download_image(poster_url)

        return QUrl().fromLocalFile(os.path.join(cache_folder, file_name))

    def _get_backdrop_path(self, backdrop_url):
        backdrop_path = download_image(backdrop_url, True)
        return QUrl().fromLocalFile(backdrop_path)

    def _get_poster(self):
        return self._poster

    def _convert_date(self, release_date: str):
        return release_date

    def _get_title(self):
        return self._title

    def _get_backdrop(self):
        return self._backdrop

    def _get_overview(self):
        return self._overview

    def _get_tagline(self):
        if self._tagline:
            return self._tagline

        return ""

    def _get_date(self):
        if self._release_date:
            datetime_obj = datetime.strptime(self._release_date, "%Y-%m-%d")
            return datetime_obj.strftime("%Y %b. %d")
        return ""

    def _get_language(self):
        if self._original_language:
            return self._original_language.upper()
        return ""

    def _get_genres(self):
        if self._genres:
            return self._genres
        return ""

    def _get_runtime(self):
        return self._runtime

    title = Property(str, _get_title, notify=movie_loaded)
    overview = Property(str, _get_overview, notify=movie_loaded)
    tagline = Property(str, _get_tagline, notify=movie_loaded)
    release_date = Property(str, _get_date, notify=movie_loaded)
    poster = Property(QUrl, _get_poster, notify=movie_loaded)
    backdrop = Property(QUrl, _get_backdrop, notify=movie_loaded)
    language = Property(str, _get_language, notify=movie_loaded)
    genres = Property(str, _get_genres, notify=movie_loaded)
    runtime = Property(str, _get_runtime, notify=movie_loaded)