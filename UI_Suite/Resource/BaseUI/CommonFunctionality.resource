*** Settings ***
Documentation       This file handles the configuration, reusable keywords

Library             SeleniumLibrary    
Library             driver_setup.py


*** Variables ***
${BROWSER_NAME}     chrome
${URL}              http://localhost:8080/


*** Keywords ***
Launch Browser And Navigate To Demo App
    ${driver_path}    Get Driver Path    ${BROWSER_NAME}
    Open Browser    browser=${BROWSER_NAME}    executable_path=${driver_path}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Set Selenium Timeout    value=10s
    Set Screenshot Directory    path=UI_Suite/screenshot
    Go To    url=${URL}
