*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Charges_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet3   #excel file


*** Keywords ***
Login To Charges Website
         Login To website
         Initialize Random Variables for Charges cycle   #Bringing the random name fuction to suit setup
Charges_Setup
         Setup
         click element                        ${XPATH_TO_CHARGERS}
New Charges cycle
         Charges_Setup
         click element                        ${NEW_BILL_BUTTON_CHARGER}
Audit click
         Charges_Setup
         click element           ${XPATH_TO_AUDIT_BUTTON_CHARGER}
         click element           ${XPATH_TO_DROPDOWN_BUTTON_CHARGER}
Edit Charges cycle
         Charges_Setup
         click element           ${EDIT_BUTTON_CHARGER}


#Fuction for generating random strings
Initialize Random Variables for Charges cycle
         ${RANDOM_NAME}=          Generate random string        12
         Set global variable      ${RANDOM_NAME}
         ${RANDOM_APP_CODE}=      Generate random string        7
         Set global variable      ${RANDOM_APP_CODE}
         ${RANDOM_EDIT_NAME}=     Generate random string        13
         Set global variable      ${RANDOM_EDIT_NAME}


#Fuctions to give to main test keyword
Give input to Charges cycle
         [Arguments]           ${NAME}     ${TYPE}       ${GL_CODE}      ${TAX_PLAN}     ${NEW_VERIFY}   ${DIS_GL_CODE}   ${DIS_APP_CODE}
         input text                        ${XPATH_TO_CHARGE_NAME_TEXTBOX}               ${NAME}
         Select From List By Label         ${XPATH_TO_TYPE_TEXTBOX}                      ${TYPE}
         Select From List By Label         ${XPATH_TO_GL_CODE_TEXTBOX_CHARGER}           ${GL_CODE}
         Run Keyword If                   '${TYPE}'!='Deposit'         Tax plan IF       ${TAX_PLAN}
         Select From List By Label         ${XPATH_TO_DISCOUNT_GL_CODE}                  ${DIS_GL_CODE}
         input text                        ${XPATH_TO_DIS_APP_CODE}                      ${DIS_APP_CODE}
         click element                     ${SAVE}
         #Waiting for confirmation
         wait until page contains          ${${NEW_VERIFY}}

Verification
         [Arguments]           ${NAME}     ${TYPE}       ${GL_CODE}    ${DIS_GL_CODE}     ${DIS_APP_CODE}
         Charges_Setup
         wait until page contains          ${NAME}
         wait until page contains          ${TYPE}
         wait until page contains          ${GL_CODE}
         wait until page contains          ${DIS_GL_CODE}
         wait until page contains          ${DIS_APP_CODE}
Auditing the new bill
         [Arguments]           ${NAME}     ${TYPE}       ${GL_CODE}    ${DIS_GL_CODE}     ${DIS_APP_CODE}
         Audit click
         wait until page contains          ${NAME}
         wait until page contains          ${TYPE}
         wait until page contains          ${GL_CODE}
         wait until page contains          ${DIS_GL_CODE}
         wait until page contains          ${DIS_APP_CODE}
Edit section
         [Arguments]   ${EDIT_NAME}   ${EDIT_VERIFY}   ${EDIT_GL_CODE}
         Edit Charges cycle
         input text                        ${XPATH_TO_CHARGE_NAME_TEXTBOX}               ${EDIT_NAME}
         Select From List By Label         ${XPATH_TO_GL_CODE_TEXTBOX_CHARGER}           ${EDIT_GL_CODE}
         click element                     ${SAVE}
         wait until page contains          ${${EDIT_VERIFY}}
Edit verification
         [Arguments]           ${TYPE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_GL_CODE}
         Charges_Setup
         wait until page contains          ${TYPE}
         wait until page contains          ${EDIT_GL_CODE}
         wait until page contains          ${DIS_GL_CODE}
         wait until page contains          ${DIS_APP_CODE}
         wait until page contains          ${EDIT_NAME}
Audit verification
         [Arguments]      ${NAME}  ${TYPE}  ${GL_CODE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_GL_CODE}
         Audit click
         wait until page contains          ${NAME}
         wait until page contains          ${TYPE}
         wait until page contains          ${GL_CODE}
         wait until page contains          ${DIS_GL_CODE}
         wait until page contains          ${DIS_APP_CODE}
         wait until page contains          ${EDIT_NAME}
         wait until page contains          ${EDIT_GL_CODE}
#fuctions for If Statements
Edit Verify &Audit for IF
         [Arguments]    ${NAME}     ${TYPE}     ${GL_CODE}    ${EDIT_NAME}  ${DIS_GL_CODE}   ${DIS_APP_CODE}  ${EDIT_VERIFY}  ${EDIT_GL_CODE}
         Verification               ${NAME}     ${TYPE}       ${GL_CODE}    ${DIS_GL_CODE}   ${DIS_APP_CODE}
         Auditing the new bill      ${NAME}     ${TYPE}       ${GL_CODE}    ${DIS_GL_CODE}   ${DIS_APP_CODE}
         Edit section   ${EDIT_NAME}  ${EDIT_VERIFY}  ${EDIT_GL_CODE}
         Run Keyword If    '${EDIT_VERIFY}'=='Pass'    Edit &Audit Verification    ${NAME}  ${TYPE}  ${GL_CODE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_GL_CODE}

Edit &Audit Verification
         [Arguments]   ${NAME}  ${TYPE}  ${GL_CODE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_GL_CODE}
         Edit verification    ${TYPE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_GL_CODE}
         Audit verification   ${NAME}  ${TYPE}  ${GL_CODE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_GL_CODE}
Edit Verify & Audit
         [Arguments]   ${NAME}     ${TYPE}     ${GL_CODE}    ${DIS_GL_CODE}   ${DIS_APP_CODE}  ${NEW_VERIFY}   ${EDIT_NAME}   ${EDIT_VERIFY}  ${EDIT_GL_CODE}
         Run Keyword If    '${NEW_VERIFY}'=='Pass'    Edit Verify &Audit for IF    ${NAME}     ${TYPE}     ${GL_CODE}    ${EDIT_NAME}  ${DIS_GL_CODE}   ${DIS_APP_CODE}  ${EDIT_VERIFY}  ${EDIT_GL_CODE}

Tax plan IF
         [Arguments]    ${TAX_PLAN}
         Select From List By Label   ${XPATH_TO_TAX_PLAN_TEXTBOX}    ${TAX_PLAN}

${ALL_CHARGER_ARGUMENTS}=   ${NAME}  ${GL_CODE}  ${TYPE}  ${TAX_PLAN}  ${NEW_VERIFY}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_VERIFY}  ${EDIT_GL_CODE}