*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Tax_Formula_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet4   #excel file

*** Keywords ***

Login To Tax Formula Website
         Login To website
         Initialize Random Variables for Tax Formula cycle   #Bringing the random name fuction to suit setup

#Required setup fuctions
Tax Formula Setup
         Setup
         click element                         ${XPATH_TO_TAX_FORMULA}
New Tax Formula cycle
         Tax Formula Setup
         click element                         ${NEW_BILL_TAX_FORMULA}
Edit Tax Formula cycle
         Tax Formula Setup
         click element                         ${XPATH_FOR_EDIT}
         click element                         ${XPATH_TAX_EDIT_BUTTON}
Audit click
         Tax Formula Setup
         click element                         ${XPATH_TO_AUDIT_TAX}
         click element                         ${XPATH_TO_DROPDOWN_TAX}


#Fuction for generating random strings
Initialize Random Variables for Tax Formula cycle
         ${RANDOM_NAME}=          Generate random string         6
         Set global variable      ${RANDOM_NAME}
         ${RANDOM_CODE}=          Generate random string         4
         Set global variable      ${RANDOM_CODE}
         ${RANDOM_EDIT_NAME}=     Generate random string        8
         Set global variable      ${RANDOM_EDIT_NAME}

#Fuctions to give to main test keyword
Give input to Tax Formula cycle
         [Arguments]   ${CODE}  ${NAME}  ${TAX_PLAN}  ${GL_CODE}  ${NEW_VERIFY}
         input text                    ${XPATH_TO_CODE_TAX_FORMULA}          ${CODE}
         input text                    ${XPATH_TO_NAME_TAX_FORMULA}          ${NAME}
         input text                    ${XPATH_TO_TAX_PLAN_FORMULA}          ${TAX_PLAN}
         Select From List By Label     ${XPATH_TO_GL_CODE_PLAN_FORMULA}      ${GL_CODE}
         click element                 ${SAVE}
         wait until page contains      ${${NEW_VERIFY}}

Verification for Tax Formula
         [Arguments]             ${CODE}     ${NAME}
         Tax Formula Setup
         wait until page contains            ${CODE}
         wait until page contains            ${NAME}

Auditing the Tax Formula
         [Arguments]             ${CODE}     ${NAME}
         Audit click
         wait until page contains            ${NAME}
         wait until page contains            ${CODE}

Edit Section for tax formula
         [Arguments]    ${EDIT_NAME}   ${EDIT_TAX}  ${EDIT_VERIFY}
         Edit Tax Formula cycle
         input text                    ${XPATH_TO_EDIT_NAME_TAX_FORMULA}    ${EDIT_NAME}
         input text                    ${XPATH_TO_EDIT_TAX_FORMULA}         ${EDIT_TAX}
         click element                 ${SAVE}
         wait until page contains      ${${EDIT_VERIFY}}

Edit verification tax formula
         [Arguments]                         ${CODE}
         Tax Formula Setup
         wait until page contains            ${CODE}


Audit Verification for edited tax formula
         [Arguments]   ${NAME}    ${TAX_PLAN}  ${EDIT_NAME}  ${EDIT_TAX}
         Audit click
         wait until page contains            ${NAME}
         wait until page contains            ${TAX_PLAN}
         wait until page contains            ${EDIT_NAME}
         wait until page contains            ${EDIT_TAX}





#fuctions for If Statements
Edit Verify &Audit for IF for tax formula
         [Arguments]         ${CODE}  ${NAME}   ${TAX_PLAN}   ${EDIT_NAME}   ${EDIT_TAX}  ${EDIT_VERIFY}
         Verification for Tax Formula           ${CODE}      ${NAME}
         Auditing the Tax Formula               ${CODE}      ${NAME}
         Edit Section for tax formula           ${EDIT_NAME}   ${EDIT_TAX}  ${EDIT_VERIFY}
         #verifing the edit bills in case of edit in bill
         Run Keyword If      '${EDIT_VERIFY}'=='Pass'       Edit Verification and Audit verifiction  ${CODE}  ${NAME}  ${TAX_PLAN}  ${EDIT_TAX}  ${EDIT_NAME}
Edit Verification and Audit verifiction
         [Arguments]    ${CODE}  ${NAME}  ${TAX_PLAN}  ${EDIT_NAME}  ${EDIT_TAX}
         Edit verification tax formula                 ${CODE}
         Audit Verification for edited tax formula     ${NAME}  ${TAX_PLAN}   ${EDIT_NAME}  ${EDIT_TAX}
#main statement for runner
Edit Verify &Audit
         [Arguments]   ${CODE}  ${NAME}  ${TAX_PLAN}  ${NEW_VERIFY}  ${EDIT_NAME}   ${EDIT_TAX}  ${EDIT_VERIFY}
         Run Keyword If  '${NEW_VERIFY}'=='Pass'   Edit Verify &Audit for IF for tax formula   ${CODE}  ${NAME}  ${TAX_PLAN}  ${EDIT_NAME}   ${EDIT_TAX}  ${EDIT_VERIFY}


${ALL_ARGUMENTS_TAX_FORMULA}=      ${CODE}  ${NAME}  ${TAX_PLAN}  ${GL_CODE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_TAX}  ${EDIT_VERIFY}