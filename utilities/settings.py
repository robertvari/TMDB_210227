import os

APP_ROOT = os.path.dirname(__file__).replace("utilities", "")
CACHE_FOLDER = os.path.join(APP_ROOT, "_data_cache")

IMAGE_SERVER = 'https://image.tmdb.org/t/p/w300'
IMAGE_BACKDROP_SERVER = 'https://image.tmdb.org/t/p/w1920_and_h800_multi_faces'