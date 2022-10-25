*** Settings ***
Documentation     Valid user login to see user Information
...               Test case TC_04    and test data present in valid_login_test.csv
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Resource          ../../Resource/Pages/HomePage.resource
Resource          ../../Resource/Pages/LoginPage.resource
Resource          ../../Resource/Pages/UserInformationPage.resource
Library           DataDriver    file=../../test_data/valid_login_test.csv
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template     Valid Login Template

*** Test Cases ***
Valid Login Test ${test_case_name}


*** Keywords ***
Valid Login Template
    [Arguments]    ${username}    ${password}    ${expected_valid_message}    ${expected_username}
    ...    ${expected_firstname}    ${expected_familyname}    ${expected_phone}
    Click Login
    Enter Login Username    ${username}
    Enter Login Password    ${password}
    Click Login Button
    Wait For Presence Of Logout
    Validate User Information Header    ${expected_valid_message}
    Validate User Information    ${expected_username}    ${expected_firstname}    ${expected_familyname}    ${expected_phone}
