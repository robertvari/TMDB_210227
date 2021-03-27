from utilities import settings
import requests, os, shutil


def download_image(image_url, backdrop=False):
    poster_file_name = image_url[1:]
    poster_path = os.path.join(settings.CACHE_FOLDER, poster_file_name)

    if os.path.exists(poster_path):
        return poster_path

    poster_url = f'{settings.IMAGE_SERVER}{image_url}'
    if backdrop:
        poster_url = f'{settings.IMAGE_BACKDROP_SERVER}{image_url}'

    response = requests.get(poster_url, stream=True)

    if response.status_code == 200:
        with open(poster_path, "wb") as f:
            response.raw.decode_content = True
            shutil.copyfileobj(response.raw, f)

    return poster_path


if __name__ == '__main__':
    poster_path = download_image(f'/lPsD10PP4rgUGiGR4CCXA6iY0QQ.jpg')