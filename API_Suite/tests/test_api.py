import json

import pytest
import requests
from assertpy import assert_that

from API_Suite.config import *
from API_Suite.helper.api_listeners import APIListerners


class TestDemoAPI(APIListerners):

    @pytest.mark.order(1)
    def test_add_user(self):
        """ TC_01 """
        file = open(JSON_ADD_USER)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json.load(file))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(201)
        assert_that(response_json['message']).is_equal_to('Created')
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(2)
    def test_get_all_users(self):
        """ TC_02 """
        headers = {"Content-Type": "application/json"}
        response = requests.get(url=BASE_URI + RESOURCE_GET_ALL_USERS, headers=headers)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(type(response_json['payload']) == list)
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(3)
    def test_get_token(self):
        """ TC_03 """
        file = open(JSON_ADD_USER)
        json_body = json.load(file)
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=(json_body["username"], json_body["password"]))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(4)
    def test_update_user(self):
        """ TC_05 """
        file = open(JSON_ADD_USER)
        json_body = json.load(file)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.put(url=BASE_URI + RESOURCE_PUT_USERS, headers=headers, json=json.load(file))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['message']).is_equal_to('Updated')
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(5)
    def test_get_user(self):
        """ TC_04 """
        file = open(JSON_ADD_USER)
        json_body = json.load(file)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.get(url=BASE_URI + RESOURCE_GET_USERS, headers=headers)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['message']).is_equal_to('retrieval succesful')
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(6)
    def test_add_existing_user(self):
        file = open(JSON_ADD_USER)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json.load(file))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(400)
        assert_that(response_json['message']).is_equal_to('User exists')
        assert_that(response_json['status']).is_equal_to('FAILURE')

    @pytest.mark.order(7)
    def test_get_token(self):
        file = open(JSON_ADD_USER)
        json_body = json.load(file)
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=(json_body["username"], json_body["password"]))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['status']).is_equal_to('SUCCESS')
