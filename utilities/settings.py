import os

APP_ROOT = os.path.dirname(__file__).replace("/utilities", "")
IMAGE_SERVER = 'https://image.tmdb.org/t/p/w300'

if __name__ == '__main__':
    print(IMAGE_SERVER + "/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg")