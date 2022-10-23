*** Settings ***
Library           SeleniumLibrary
Resource          ../../Resource/Base/CommonFunctionality.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser

*** Test Cases ***
Register With Existing Account Test
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=demo2
    Input Password    locator=id:password    password=demo1
    Input Text    locator=id:firstname    text=demo1f
    Input Text    locator=id:lastname    text=demo1l
    Input Text    locator=id:phone    text=80956722
    Click Button    locator=Register    
    Element Should Contain    locator=xpath=//div[contains(text(),'already')]    expected=User demo2 is already registered.    message=User should have been displayed with message as 'User is already registered'

Register Without Filling Required Field Test
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=demo2
    Input Password    locator=id:password    password=demo1
    Input Text    locator=id:firstname    text=demo1f
    Input Text    locator=id:lastname    text=demo1l
    Input Text    locator=id:phone    text=80956722
    Click Button    locator=Register  
    

*** Keywords ***
Register Without Filling Required Field Template
    [Arguments]     ${username}    ${password}    ${firstname}    ${familyname}    ${phone}    