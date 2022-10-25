*** Settings ***
Documentation     This resource file handles web elements inside homepage of Signant demo app.
Resource          ../BaseUI/CommonFunctionality.resource

*** Variables ***
${REGISTER_LOCATOR}    link=Register
${LOGIN_LOCATOR}    link=Log In
${DEMOAPP_LOCATOR}    link=Log In

*** Keywords ***
Click Register
    [Documentation]    Click on Register Link
    ...    \nExample:
    ...    | Click Register |
    Click Element    ${REGISTER_LOCATOR}

Click Login
    [Documentation]    Click on Login Link
    ...    \nExample:
    ...    | Click Login |
    Click Element    ${LOGIN_LOCATOR}

Click DemoAPP
    [Documentation]    Click on DemoApp Link
    ...    \nExample:
    ...    | Click DemoApp |
    Click Element    ${DEMOAPP_LOCATOR}
