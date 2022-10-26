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
        assert_that(201).is_equal_to(response.status_code)
        assert_that('Created').is_equal_to(response_json['message'])
        assert_that('SUCCESS').is_equal_to(response_json['status'])

    @pytest.mark.order(2)
    def test_get_all_users(self):
        """ TC_02 - Get All Users list from the system """
        headers = {"Content-Type": "application/json"}
        response = requests.get(url=BASE_URI + RESOURCE_GET_ALL_USERS, headers=headers)
        response_json = response.json()
        assert_that(200).is_equal_to(response.status_code)
        assert_that(type(response_json['payload']) == list)
        assert_that('SUCCESS').is_equal_to(response_json['status'])

    @pytest.mark.order(3)
    def test_get_token(self):
        """ TC_03 - Get token using valid username and password """
        json_body = self.get_json(ADD_USER_JSON)
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=(json_body["username"], json_body["password"]))
        response_json = response.json()
        assert_that(200).is_equal_to(response.status_code)
        assert_that('SUCCESS').is_equal_to(response_json['status'])

    @pytest.mark.order(4)
    def test_update_user(self):
        """ TC_05 - Update existing user details such as firstname, lastname, phone """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.put(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"])
                                , headers=headers, json=json_body["update_details"])
        response_json = response.json()
        assert_that(201).is_equal_to(response.status_code)
        assert_that('Updated').is_equal_to(response_json['message'])
        assert_that('SUCCESS').is_equal_to(response_json['status'])

    @pytest.mark.order(5)
    def test_get_user(self):
        """ TC_04 - Fetching the upated record for one user and verifying the firstname, lastname, phone """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json",
                   "Token": self.get_token(json_body["username"], json_body["password"])}
        response = requests.get(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"]),
                                headers=headers)
        response_json = response.json()
        assert_that(200).is_equal_to(response.status_code)
        assert_that(response_json['message']).is_equal_to('retrieval succesful')
        assert_that('SUCCESS').is_equal_to(response_json['status'])
        assert_that(json_body["update_details"]["firstname"]).is_equal_to(response_json['payload']['firstname'])
        assert_that(json_body["update_details"]["lastname"]).is_equal_to(response_json['payload']['lastname'])
        assert_that(json_body["update_details"]["phone"]).is_equal_to(response_json['payload']['phone'])

    @pytest.mark.order(6)
    def test_add_existing_user(self):
        """ TC_06 - Add existing user and verifying User exists message """
        json_body = self.get_json(ADD_USER_JSON)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json_body)
        response_json = response.json()
        assert_that(400).is_equal_to(response.status_code)
        assert_that('User exists').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])

    @pytest.mark.order(7)
    def test_get_token(self):
        """ TC_07 & TC_08 -  To check token generation for invalid account """
        json_body = self.get_json(ADD_USER_JSON)
        response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=("xx", json_body["password"]))
        response_json = response.json()
        assert_that(401).is_equal_to(response.status_code)
        assert_that('Invalid User').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])

    @pytest.mark.order(8)
    def test_add_existing_user(self):
        """ TC_09 - Add user by missing the required field """
        json_body = self.get_json(INVALID_ADD_USER_JSON)
        headers = {"Content-Type": "application/json"}
        response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json_body)
        response_json = response.json()
        assert_that(400).is_equal_to(response.status_code)
        assert_that('Field missing').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])

    @pytest.mark.order(9)
    def test_get_user_with_no_token(self):
        """ TC_10 To get registered user with no token """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json"}
        response = requests.get(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"]),
                                headers=headers)
        response_json = response.json()
        assert_that(401).is_equal_to(response.status_code)
        assert_that('Token authentication required').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])

    @pytest.mark.order(10)
    def test_get_user_with_invalid_token(self):
        """ TC_11 To get registered user with invalid token """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json",
                   "Token": "ABC"}
        response = requests.get(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"]),
                                headers=headers)
        response_json = response.json()
        assert_that(401).is_equal_to(response.status_code)
        assert_that('Invalid Token').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])

    @pytest.mark.order(11)
    def test_update_user_with_no_token(self):
        """ TC_12 - Update without token """
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json"}
        response = requests.put(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"])
                                , headers=headers, json=json_body["update_details"])
        response_json = response.json()
        assert_that(401).is_equal_to(response.status_code)
        assert_that('Token authentication required').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])

    @pytest.mark.order(12)
    def test_update_user_with_invalid_token(self):
        """ TC_13 - Update with invalid token"""
        json_body = self.get_json(UPDATE_USER_JSON)
        headers = {"Content-Type": "application/json",
                   "Token": "ABC"}
        response = requests.put(url=BASE_URI + RESOURCE_GET_PUT_USER.replace("{username}", json_body["username"])
                                , headers=headers, json=json_body["update_details"])
        response_json = response.json()
        assert_that(401).is_equal_to(response.status_code)
        assert_that('Invalid Token').is_equal_to(response_json['message'])
        assert_that('FAILURE').is_equal_to(response_json['status'])
