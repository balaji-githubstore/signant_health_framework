import json

import pytest
import requests
from assertpy import assert_that

from API_Suite.config import *
from API_Suite.helper.api_listeners import APIListerners


class TestDemoAPI(APIListerners):

    @pytest.mark.order(1)
    def test_add_user(self):
        """ TC_01 - Adding the user to the System """
        json_body = self.get_json(ADD_USER_JSON)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json_body)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(201)
        assert_that(response_json['message']).is_equal_to('Created')
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(2)
    def test_get_all_users(self):
        """ TC_02 - Get All Users list from the system """
        headers = {"Content-Type": "application/json"}
        response = requests.get(url=BASE_URI + RESOURCE_GET_ALL_USERS, headers=headers)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(type(response_json['payload']) == list)
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(3)
    def test_get_token(self):
        """ TC_03 - Get token using valid username and password """
        json_body = self.get_json(ADD_USER_JSON)
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=(json_body["username"], json_body["password"]))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(4)
    def test_update_user(self):
        """ TC_05 - Update existing user details such as firstname, lastname, phone """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.put(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"])
                                , headers=headers, json=json_body["update_details"])
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(201)
        assert_that(response_json['message']).is_equal_to('Updated')
        assert_that(response_json['status']).is_equal_to('SUCCESS')

    @pytest.mark.order(5)
    def test_get_user(self):
        """ TC_04 - Fetching the upated record for one user and verifying the firstname, lastname, phone """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.get(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"]),
                                headers=headers)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(200)
        assert_that(response_json['message']).is_equal_to('retrieval succesful')
        assert_that(response_json['status']).is_equal_to('SUCCESS')
        assert_that(response_json['payload']['firstname']).is_equal_to(json_body["update_details"]["firstname"])
        assert_that(response_json['payload']['lastname']).is_equal_to(json_body["update_details"]["lastname"])
        assert_that(response_json['payload']['phone']).is_equal_to(json_body["update_details"]["phone"])

    @pytest.mark.order(6)
    def test_add_existing_user(self):
        """ TC_06 - Add existing user and verifying User exists message """
        json_body = self.get_json(ADD_USER_JSON)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json_body)
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(400)
        assert_that(response_json['message']).is_equal_to('User exists')
        assert_that(response_json['status']).is_equal_to('FAILURE')

    @pytest.mark.order(7)
    def test_get_token(self):
        json_body = self.get_json(ADD_USER_JSON)
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=("xx", json_body["password"]))
        response_json = response.json()
        assert_that(response.status_code).is_equal_to(401)
        assert_that(response_json['message']).is_equal_to('Invalid User')
        assert_that(response_json['status']).is_equal_to('FAILURE')
