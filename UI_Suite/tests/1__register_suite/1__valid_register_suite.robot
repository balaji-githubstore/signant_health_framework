*** Settings ***
Documentation     Valid account registration
...               Test case TC_01 and test data present in valid_register_test.csv
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Resource          ../../Resource/Pages/HomePage.resource
Resource          ../../Resource/Pages/RegisterPage.resource
Resource          ../../Resource/Pages/LoginPage.resource
Library           DataDriver    file=../../test_data/valid_register_test.csv
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser

*** Test Cases ***
Valid Register Test ${test_case_name}
    [Template]    Valid Register Template

*** Keywords ***
Valid Register Template
    [Arguments]    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}    ${expected_value}
    Click Register
    Enter Username    ${username}
    Enter Password    ${password}
    Enter Firstname    ${firstname}
    Enter Familyname    ${familyname}
    Enter Phone    ${phone}
    Click Register Button
    Validate LogIn Header    ${expected_value}
