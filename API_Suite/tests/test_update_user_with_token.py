import json

import pytest
import requests
from assertpy import assert_that

from API_Suite.config import *
from API_Suite.helper.api_listeners import APIListerners


class TestGetAllUser(APIListerners):

    def test_update_user(self):
        file = open(JSON_ADD_USER)
        json_body = json.load(file)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.put(url=BASE_URI + RESOURCE_PUT_USERS, headers=headers, json=json.load(file))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['message']).is_equal_to('Updated')
        assert_that(response_json['status']).is_equal_to('SUCCESS')
