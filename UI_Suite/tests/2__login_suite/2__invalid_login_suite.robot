*** Settings ***
Documentation     Invalid user login
...               Test case TC_05
...               test data for the combination of invalid username and password are taken
...               from excel at test_data/ui_test_data.xlsx
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Resource          ../../Resource/Pages/HomePage.resource
Resource          ../../Resource/Pages/LoginPage.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template     Invalid Login Template

Default Tags    Login

*** Test Cases ***
Invalid Login Test TC1
    john    john123    You provided incorrect login details

Invalid Login Test TC2
    john    john123    You provided incorrect login details

Empty Username Tooltip Test
    ${EMPTY}    john123    Please fill out this field.

Empty Password Tooltip Test
    john    ${EMPTY}    Please fill out this field.

*** Keywords ***
Invalid Login Template
    [Arguments]    ${username}    ${password}    ${expected_error_message}
    Click Login
    Enter Login Username    ${username}
    Enter Login Password    ${password}
    Click Login Button
    Validate Invalid Login Error And Tooltip    ${username}    ${password}    ${expected_error_message}
