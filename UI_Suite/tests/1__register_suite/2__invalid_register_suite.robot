*** Settings ***
Documentation     Invalid account registration
...               Test case TC_02 and test data present in invalid_existing_register_test.csv
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Resource          ../../Resource/Pages/HomePage.resource
Resource          ../../Resource/Pages/RegisterPage.resource
Library           DataDriver    file=../../test_data/invalid_existing_register_test.csv
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser

Default Tags    Register

*** Test Cases ***
Register With Existing Account Test ${test_case_name}
    [Template]    Register With Existing Account Template

*** Keywords ***
Register With Existing Account Template
    [Arguments]    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}    ${expected_message}
    Click Register
    Enter Username    ${username}
    Enter Password    ${password}
    Enter Firstname    ${firstname}
    Enter Familyname    ${familyname}
    Enter Phone    ${phone}
    Click Register Button
    Validate Existing User Message    ${expected_message}
