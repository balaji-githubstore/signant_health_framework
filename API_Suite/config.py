import os

BASE_URI='http://localhost:8080'
RESOURCE_API_TOKEN="/api/auth/token"
RESOURCE_GET_ALL_USERS="/api/users"
RESOURCE_POST_USER="/api/users"
RESOURCE_GET_PUT_USER="/api/users/{username}"


path=os.getcwd().split("API_Suite")[0]

ADD_USER_JSON=path+"\\API_Suite\\test_data\\add_users.json"
UPDATE_USER_JSON=path+"\\API_Suite\\test_data\\update_users.json"
INVALID_ADD_USER_JSON=path+"\\API_Suite\\test_data\\invalid_add_users.json"

