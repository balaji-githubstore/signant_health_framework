*** Settings ***
Documentation     Valid account registration
...               Test case TC_01
Resource          ../../Resource/Base/CommonFunctionality.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser

*** Test Cases ***
Valid Register Test
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=demo2
    Input Password    locator=id:password    password=demo1
    Input Text    locator=id:firstname    text=demo1f
    Input Text    locator=id:lastname    text=demo1l
    Input Text    locator=id:phone    text=80956722
    Click Button    locator=Register
    Element Text Should Be    locator=xpath=//section[@class='content']//h1    expected=Log In    
    ...    message=Login Page should have been displayed
