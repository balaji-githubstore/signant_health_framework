*** Settings ***
Documentation     Valid user login to see user Information
...               Test case TC_04
Resource          ../../Resource/Base/CommonFunctionality.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser

*** Test Cases ***
Valid Login Test
    Click Link    locator=link=Log In
    Input Text    locator=id=username    text=demo1
    Input Password    locator=id=password    password=demo1
    Click Element    locator=css=[value='Log In']
    Wait Until Page Contains Element    locator=link=Log Out
    Element Text Should Be    locator=xpath=//section[@class='content']//h1    expected=User Information    
    ...    message=User should have been navigated to login page
