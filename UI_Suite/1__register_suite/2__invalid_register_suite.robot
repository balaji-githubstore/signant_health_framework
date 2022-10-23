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
    [Template]    Register Without Filling Required Field Template
    Username Tooltip Test    ${EMPTY}    welcome@123    john    wick    3344    Please fill out this field
    Password Tooltip Test    john0012    ${EMPTY}    john    wick    3344    Please fill out this field
    Firstname Tooltip Test    john0012    welcome@123    ${EMPTY}    wick    3344    Please fill out this field
    FamilyName Tooltip Test    john0012    welcome@123    john    ${EMPTY}    3344    Please fill out this field
    Phone Tooltip Test    john0012    welcome@123    john    wick    ${EMPTY}    Please fill out this field

*** Keywords ***
Register Without Filling Required Field Template
    [Arguments]    ${test_name}    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}    ${expected_tooltip}
    Log    ${test_name}
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=${username}
    Input Password    locator=id:password    password=${password}
    Input Text    locator=id:firstname    text=${firstname}
    Input Text    locator=id:lastname    text=${familyname}
    Input Text    locator=id:phone    text=${phone}
    Click Button    locator=Register
    FOR    ${i}    IN RANGE    0    5 
        IF    ${username} == ${EMPTY}
            ${tooltip}    Execute Javascript    return document.querySelectorAll('input')[${i}].validationMessage
        END
        ${tooltip}    Execute Javascript    return document.querySelectorAll('input')[${i}].validationMessage
        ${field_name}    Execute Javascript    return document.querySelectorAll('input')[${i}].id
        Log To Console    ${tooltip}
        Log To Console    ${field_name}
    END
        