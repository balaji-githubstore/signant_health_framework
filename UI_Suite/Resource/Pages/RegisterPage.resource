*** Settings ***
Documentation     This resource file handles web elements inside register page of Signant demo app.
Resource          ../BaseUI/CommonFunctionality.resource

*** Variables ***
${USERNAME_LOCATOR}    css=#username
${PASSWORD_LOCATOR}    css=#password
${FIRSTNAME_LOCATOR}    css=#firstname
${FAMILYNAME_LOCATOR}    css=#lastname
${PHONE_LOCAOTR}    css=#phone
${REGISTERBUTTON_LOCATOR}    Register
${ERRORMESSAGE_LOCATOR}    xpath=//div[contains(text(),'already')]

*** Keywords ***
Enter Username
    [Arguments]    ${username}
    [Documentation]    Types the given text into username field
    ...    \nExample:
    ...    | Enter Username | john_01 |
    Input Text    ${USERNAME_LOCATOR}    ${username}

Enter Password
    [Arguments]    ${password}
    [Documentation]    Types the given text into password field
    ...    \nExample:
    ...    | Enter Password | john_01 |
    Input Text    ${PASSWORD_LOCATOR}    ${password}

Enter Firstname
    [Arguments]    ${firstname}
    [Documentation]    Types the given text into firstname field
    ...    \nExample:
    ...    | Enter Firstname | john |
    Input Text    ${FIRSTNAME_LOCATOR}    ${firstname}

Enter Familyname
    [Arguments]    ${familyname}
    [Documentation]    Types the given text into familyname field
    ...    \nExample:
    ...    | Enter Familyname | ken |
    Input Text    ${FAMILYNAME_LOCATOR}    ${familyname}

Enter Phone
    [Arguments]    ${phone}
    [Documentation]    Types the given text into password field
    ...    \nExample:
    ...    | Enter Phone | 1223344 |
    ...    | Enter Phone | 988 |
    Input Text    ${PHONE_LOCAOTR}    ${phone}

Click Register Button
    [Documentation]    Click on Register Button
    ...    \nExample:
    ...    | Click Register Button |
    Click Button    ${REGISTERBUTTON_LOCATOR}

Get Tooltip Message
    [Arguments]    ${username}    ${password}    ${firstname}    ${familyname}    ${phone}
    [Documentation]    Get Tooltip Message For Empty Field
    ...    \nExample:
    ...    | Get Tooltip Message |    ${EMPTY} | welc12 | john | ken | 9908 |
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
    [Return]    ${actual_tooltip}

Validate Existing User Message
    [Documentation]    Click on Register Button
    ...    \nExample:
    ...    | Validate Existing User Message | User is already registered |
    [Arguments]    ${expected_message}
    Element Should Contain    locator=${ERRORMESSAGE_LOCATOR}    expected=${expected_message}
    ...    message=User should have been displayed with message as 'User is already registered'
