import tmdbsimple as tmdb
from dotenv import load_dotenv
from utilities import settings
import os

ENV_PATH = os.path.join(settings.APP_ROOT, ".env")
load_dotenv(ENV_PATH)

tmdb.API_KEY = os.getenv('TMDB_API_KEY')

movie = tmdb.Movies()
result = movie.popular()

for i in result["results"][:3]:
    print(i.get("title"))
    print(i.get('release_date'))
    print(i.get('vote_average'))
    print(f"{settings.IMAGE_SERVER}{i.get('poster_path')}")