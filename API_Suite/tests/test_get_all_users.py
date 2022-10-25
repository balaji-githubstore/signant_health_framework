import json

import pytest
import requests
from assertpy import assert_that

from API_Suite.config import *


class TestGetAllUser:
    def test_get_all_users(self):
        headers = {"Content-Type": "application/json"}
        response = requests.get(url=BASE_URI + RESOURCE_GET_ALL_USERS, headers=headers)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['status']).is_equal_to('SUCCESS')
        assert_that(type(response_json['payload'])==list)








