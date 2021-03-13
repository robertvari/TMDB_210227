import tmdbsimple as tmdb
from dotenv import load_dotenv
from utilities import settings
import os

ENV_PATH = os.path.join(settings.APP_ROOT, ".env")
load_dotenv(ENV_PATH)

tmdb.API_KEY = os.getenv('TMDB_API_KEY')

movie = tmdb.Movies()
result = movie.popular()

for i in result["results"]:
    print(i)