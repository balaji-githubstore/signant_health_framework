*** Settings ***
Documentation     Invalid account registration
...               Test case TC_02 and test data present in invalid_existing_register_test.csv
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
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
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=${username}
    Input Password    locator=id:password    password=${password}
    Input Text    locator=id:firstname    text=${firstname}
    Input Text    locator=id:lastname    text=${familyname}
    Input Text    locator=id:phone    text=${phone}
    Click Button    locator=Register
    Element Should Contain    locator=xpath=//div[contains(text(),'already')]    expected=${expected_message}
    ...    message=User should have been displayed with message as 'User is already registered'
