*** Settings ***
Documentation     Valid user login to see user Information
...               Test case TC_04  and test data present in valid_login_test.csv
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Library           DataDriver    file=../../test_data/valid_login_test.csv
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template    Valid Login Template

Default Tags    Login

*** Test Cases ***
Valid Login Test ${test_case_name}


*** Keywords ***
Valid Login Template
    [Arguments]    ${username}    ${password}    ${expected_valid_message}    ${expected_username}    
    ...    ${expected_firstname}    ${expected_familyname}    ${expected_phone}
    Click Link    locator=link=Log In
    Input Text    locator=id=username    text=${username}
    Input Password    locator=id=password    password=${password}
    Click Element    locator=css=[value='Log In']
    Wait Until Page Contains Element    locator=link=Log Out
    Element Text Should Be    locator=xpath=//section[@class='content']//h1    expected=${expected_valid_message}
    ...    message=User should have been navigated to login page
    Element Text Should Be    locator=id:username    expected=${expected_username}
    Element Text Should Be    locator=id:firstname    expected=${expected_firstname}
    Element Text Should Be    locator=id:lastname    expected=${expected_familyname}
    Element Text Should Be    locator=id:phone    expected=${expected_phone}