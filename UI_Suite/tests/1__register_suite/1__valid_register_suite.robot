*** Settings ***
Documentation     Valid account registration
...               Test case TC_01 and test data present in valid_register_test.csv
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Library           DataDriver    file=../../test_data/valid_register_test.csv
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser

Default Tags    Register

*** Test Cases ***
Valid Register Test ${test_case_name}
    [Template]    Valid Register Template

*** Keywords ***
Valid Register Template
    [Arguments]    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}    ${expected_value}
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=${username}
    Input Password    locator=id:password    password=${password}
    Input Text    locator=id:firstname    text=${firstname}
    Input Text    locator=id:lastname    text=${familyname}
    Input Text    locator=id:phone    text=${phone}
    Click Button    locator=Register
    Element Text Should Be    locator=xpath=//section[@class='content']//h1    expected=${expected_value}
    ...    message=Login Page should have been displayed
    
    
    