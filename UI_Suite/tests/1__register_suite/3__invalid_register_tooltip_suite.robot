*** Settings ***
Documentation     Invalid account registration
...               Test case TC_03
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template     Register Without Filling Required Field Template

Default Tags    Register

*** Test Cases ***
Empty Username Tooltip Test
    [Documentation]    Verify username tooltip message
    ${EMPTY}    welcome@123    john    wick    3344    Please fill out this field.

Empty Password Tooltip Test
    [Documentation]    Verify password tooltip message
    john0012    ${EMPTY}    john    wick    3344    Please fill out this field.

Empty Firstname Tooltip Test
    [Documentation]    Verify firstname tooltip message
    john0012    welcome@123    ${EMPTY}    wick    3344    Please fill out this field.

Empty FamilyName Tooltip Test
    [Documentation]    Verify familyname tooltip message
    john0012    welcome@123    john    ${EMPTY}    3344    Please fill out this field.

Empty Phone Tooltip Test
    [Documentation]    Verify phone tooltip message
    john0012    welcome@123    john    wick    ${EMPTY}    Please fill out this field.

*** Keywords ***
Register Without Filling Required Field Template
    [Arguments]    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}    ${expected_tooltip}
    Click Link    locator=link=Register
    Input Text    locator=id:username    text=${username}
    Input Password    locator=id:password    password=${password}
    Input Text    locator=id:firstname    text=${firstname}
    Input Text    locator=id:lastname    text=${familyname}
    Input Text    locator=id:phone    text=${phone}
    Click Button    locator=Register
    IF    '${username}' == '${EMPTY}'
        Set Local Variable    ${locator}    \#username
    ELSE IF    '${password}' == '${EMPTY}'
        Set Local Variable    ${locator}    \#password
    ELSE IF    '${firstname}' == '${EMPTY}'
        Set Local Variable    ${locator}    \#firstname
    ELSE IF    '${familyname}' == '${EMPTY}'
        Set Local Variable    ${locator}    \#lastname
    ELSE IF    '${phone}' == '${EMPTY}'
        Set Local Variable    ${locator}    \#phone
    END
    ${actual_tooltip}    Execute Javascript    return document.querySelector('${locator}').validationMessage
    Should Be Equal    ${expected_tooltip}    ${actual_tooltip}
