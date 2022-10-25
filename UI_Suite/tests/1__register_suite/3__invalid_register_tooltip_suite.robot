*** Settings ***
Documentation     Invalid account registration
...               Test case TC_03
Resource          ../../Resource/BaseUI/CommonFunctionality.resource
Resource          ../../Resource/Pages/RegisterPage.resource
Resource          ../../Resource/Pages/HomePage.resource
Resource          ../../Resource/Pages/RegisterPage.resource
Test Setup        Launch Browser And Navigate To Demo App
Test Teardown     Close Browser
Test Template     Register Without Filling Required Field Template

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
    Click Register
    Enter Username    ${username}
    Enter Password    ${password}
    Enter Firstname    ${firstname}
    Enter Familyname    ${familyname}
    Enter Phone    ${phone}
    Click Register Button
    ${actual_tooltip}    Get Tooltip Message    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}
    Should Be Equal    ${expected_tooltip}    ${actual_tooltip}
