*** Settings ***
Documentation     This resource file handles web elements inside loginpage of Signant demo app.
Resource          ../BaseUI/CommonFunctionality.resource

*** Variables ***
${LOGINUSERNAME_LOCATOR}    css=#username
${LOGINPASSWORD_LOCATOR}    css=#password
${LOGINBUTTON_LOCATOR}    css=[value='Log In']
${ERRORMESSAGE_LOCATOR}    xpath=//div[contains(text(),'already')]
${LOGINHEADER_LOCATOR}    xpath=//section[@class='content']//h1

*** Keywords ***
Enter Login Username
    [Arguments]    ${username}
    [Documentation]    Types the given text into username field
    ...    \nExample:
    ...    | Enter Username | john_01 |
    Input Text    ${LOGINUSERNAME_LOCATOR}    ${username}

Enter Login Password
    [Arguments]    ${password}
    [Documentation]    Types the given text into password field
    ...    \nExample:
    ...    | Enter Password | john_01 |
    Input Text    ${LOGINPASSWORD_LOCATOR}    ${password}

Click Login Button
    [Documentation]    Click on Login Button
    ...    \nExample:
    ...    | Click Login Button |
    Click Button    ${LOGINBUTTON_LOCATOR}

Validate LogIn Header
    [Documentation]    Click on Register Button
    ...    \nExample:
    ...    | Validate LogIn Header    | Log In |
    [Arguments]    ${expected_value}
    Element Text Should Be    locator=${LOGINHEADER_LOCATOR}    expected=${expected_value}
    ...    message=Login Page should have been displayed

Validate Invalid Login Error And Tooltip
    [Arguments]    ${username}    ${password}    ${expected_error_message}
    [Documentation]    Verify tooltip and error message
    ...    \nExample:
    ...    | Validate Invalid Login Error And Tooltip    | You provided incorrect login details |
    IF    '${username}' == '${EMPTY}'
        ${actual_tooltip}    Execute Javascript    return document.querySelector('#username').validationMessage
        Should Be Equal    ${expected_error_message}    ${actual_tooltip}
    ELSE IF    '${password}' == '${EMPTY}'
        ${actual_tooltip}    Execute Javascript    return document.querySelector('#password').validationMessage
        Should Be Equal    ${expected_error_message}    ${actual_tooltip}
    ELSE
        Element Should Contain    locator=xpath=//p[contains(text(),'incorrect')]    expected=${expected_error_message}
        ...    message=User should have been displayed with message as 'You provided incorrect login details'
    END
