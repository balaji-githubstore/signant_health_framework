import json

import pytest
import requests
from assertpy import assert_that

from API_Suite.config import *


def get_token():
    global access_token
    response = requests.get(BASE_URI + RESOURCE_API_TOKEN, auth=('kim_0198d', 'kim_123'))
    return response.json()['token']


def test_get_all_users():
    headers = {"Content-Type": "application/json"}
    response = requests.get(url=BASE_URI + RESOURCE_GET_ALL_USERS, headers=headers)
    response_text = response.json()
    print(response_text)
    assert_that(response.status_code).is_equal_to(201)

def test_add_user():
    file = open(JSON_ADD_USER)
    headers = {"Content-Type": "application/json"}
    response = requests.post(url=BASE_URI + RESOURCE_POST_USER, headers=headers, json=json.load(file)[0])
    response_text = response.json()
    print(response_text)
    assert_that(response.status_code).is_equal_to(201)


def test_get_user():
    headers = {"Content-Type": "application/json", "Token": get_token()}
    response = requests.get(url=BASE_URI + RESOURCE_GET_USERS, headers=headers)
    response_text = response.json()
    print(response_text)
    assert_that(response.status_code).is_equal_to(200)


def test_update_user():
    file = open(JSON_ADD_USER)
    headers = {"Content-Type": "application/json", "Authorization": get_token()}
    response = requests.put(url=BASE_URI + RESOURCE_PUT_USERS, headers=headers, json=json.load(file))
    response_text = response.json()
    print(response_text)
    assert_that(response.status_code).is_equal_to(200)
