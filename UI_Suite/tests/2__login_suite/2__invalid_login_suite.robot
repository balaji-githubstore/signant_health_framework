*** Settings ***
Documentation     Invalid user login
...               Test case TC_05
...               test data for the combination of invalid username and password are taken
...               from excel at test_data/ui_test_data.xlsx
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
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
    Click Link    locator=link=Log In
    Input Text    locator=id=username    text=${username}
    Input Password    locator=id=password    password=${password}
    Click Element    locator=css=[value='Log In']
    IF    '${username}' == '${EMPTY}'
        ${actual_tooltip}    Execute Javascript    return document.querySelector('#username').validationMessage
        Should Be Equal    ${expected_error_message}    ${actual_tooltip}
    ELSE IF    '${password}' == '${EMPTY}'
        ${actual_tooltip}    Execute Javascript    return document.querySelector('#password').validationMessage
        Should Be Equal    ${expected_error_message}    ${actual_tooltip}
    ELSE
        Element Should Contain    locator=xpath=//p[contains(text(),'incorrect')]    expected=${expected_error_message}
        ...    message=User should have been displayed with message as 'You provided incorrect login details'
    END
