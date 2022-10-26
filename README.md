# Signant Health Demo web App/API Automation #

## TestCase Documentation ##
Check the file in project directory with name as UI_API_TestCaseDoc.xlsx

## Installation Instructions ##
Install the requirements.txt

## Executable Instructions ##
To run the API automation, you can trigger the run_api_test.sh file
To run the UI automation, you can trigger the run_ui_test.sh file

## Acceptance Criteria - Automation Project Description ##

As a UI user I can: (Using Robot Framework)

 ## IMPORTANT NOTE - UI PROJECT 1 ##
 **Script without PAGE OBJECT MODEL & Keyword documentation present in branch 'master'**
 1. Register through web portal - **Test Cases present inside UI_Suite\tests\1__register_suite**
 2. Review my own user information from the main view - **Test Cases present inside UI_Suite\tests\2__login_suite**

 ## IMPORTANT NOTE - UI PROJECT 2 ##
**Script with PAGE OBJECT MODEL & Keyword documentation present in branch 'master-pageobject'**
 1. Register through web portal - **Test Cases present inside UI_Suite\tests\1__register_suite**
 2. Review my own user information from the main view - **Test Cases present inside UI_Suite\tests\2__login_suite**



As an API Consumer I can: (Using Python-PyTest Framework)
 ## IMPORTANT NOTE - API PROJECT 3 ##
**Test Cases present inside API_Suite\tests\test_api.py**
 1. Register new users
 2. Review users registered in system
 3. If authenticated I can get personal information of users
 4. If authenticated I can update personal information of users





