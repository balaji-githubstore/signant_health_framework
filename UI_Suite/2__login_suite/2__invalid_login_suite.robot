*** Settings ***
Documentation     Invalid user login 
...               Test case TC_02 and TC_03
Library           SeleniumLibrary
Resource          ../../Resource/Base/CommonFunctionality.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template    Invalid Login Template

*** Test Cases ***
Invalid Login Test TC1    john    john123    Login Failure    You provided incorrect login details
Invalid Login Test TC2  john    john123    Login Failure    You provided incorrect login details

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
