import json

import requests

from API_Suite.config import *


class APIListerners():
    access_token = None

    def get_token(self, username, password):
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=(username, password))
        access_token = response.json()['token']
        return access_token

    def get_json(self,file):
        file = open(file)
        json_body = json.load(file)
        return json_body
