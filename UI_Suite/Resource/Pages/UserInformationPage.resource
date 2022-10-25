*** Settings ***
Documentation     This resource file handles web elements inside user Information page of Signant demo app.
Resource          ../BaseUI/CommonFunctionality.resource

*** Variables ***
${USERNAME_LOCATOR}    css=#username
${PASSWORD_LOCATOR}    css=#password
${FIRSTNAME_LOCATOR}    css=#firstname
${FAMILYNAME_LOCATOR}    css=#lastname
${PHONE_LOCAOTR}    css=#phone
${LOGOUT_LOCAOTR}    link=Log Out
${USERINFOHEADEAR_LOCATOR}    xpath=//section[@class='content']//h1

*** Keywords ***
Wait For Presence Of Logout
    Wait Until Page Contains Element    ${LOGOUT_LOCAOTR}

Validate User Information Header
    [Arguments]    ${expected_valid_message}
    [Documentation]    Validate User Information Header
    ...    \nExample:
    ...    | Validate User Information Header | User Information |
    Element Text Should Be    locator=${USERINFOHEADEAR_LOCATOR}    expected=${expected_valid_message}
    ...    message=User should have been navigated to login page

Validate User Information
    [Arguments]    ${expected_username}    ${expected_firstname}    ${expected_familyname}    ${expected_phone}
    [Documentation]    Validate User Information such as firstname, lastname, phone
    ...    \nExample:
    ...    | Validate User Information | John | John123 | Jack | 89988 |
    Element Text Should Be    locator=${USERNAME_LOCATOR}    expected=${expected_username}
    Element Text Should Be    locator=${FIRSTNAME_LOCATOR}    expected=${expected_firstname}
    Element Text Should Be    locator=${FAMILYNAME_LOCATOR}    expected=${expected_familyname}
    Element Text Should Be    locator=${PHONE_LOCAOTR}    expected=${expected_phone}
