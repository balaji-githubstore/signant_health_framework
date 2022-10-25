import json

import pytest
import requests
from assertpy import assert_that

from API_Suite.config import *


class TestAddUser:

    @pytest.mark.order(1)
    def test_add_user(self):
        file = open(JSON_ADD_USER)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json.load(file))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(201)
        assert_that(response_json['message']).is_equal_to('Created')
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(2)
    def test_add_existing_user(self):
        file = open(JSON_ADD_USER)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json.load(file))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(400)
        assert_that(response_json['message']).is_equal_to('User exists')
        assert_that(response_json['status']).is_equal_to('FAILURE')
