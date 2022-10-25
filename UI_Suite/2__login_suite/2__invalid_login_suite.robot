*** Settings ***
Documentation     Invalid user login
...               Test case TC_05
...               test data for the combination of invalid username and password are taken
...               from excel at test_data/ui_test_data.xlsx
Resource          ../../Resource/Base/CommonFunctionality.resource
Library           DataDriver    file=../test_data/ui_test_data.xlsx    sheet_name=InvalidLoginTest
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template     Invalid Login Template

*** Test Cases ***
${testcase_name}


*** Keywords ***
Invalid Login Template
    [Arguments]    ${username}    ${password}    ${expected_header}    ${expected_invalid_message}
    Click Link    locator=link=Log In
    Input Text    locator=id=username    text=${username}
    Input Password    locator=id=password    password=${password}
    Click Element    locator=css=[value='Log In']
    Element Text Should Be    locator=xpath=//section[@class='content']//h1    expected=${expected_header}
    Element Should Contain    locator=xpath=//p[contains(text(),'incorrect')]    expected=${expected_invalid_message}
    ...    message=User should have been displayed with message as 'You provided incorrect login details'
