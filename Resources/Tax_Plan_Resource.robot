*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Tax_Plan_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet5   #excel file

*** Keywords ***

Login To Tax Plan Website
         Login To website
         Initialize Random Variables for Tax Plan cycle   #Bringing the random name fuction to suit setup

#Required setup fuctions
Tax Plan Setup
         Setup
         click element                ${XPATH_TO_Tax_Plan_BUTTON}
New Tax Plan cycle
         Tax Plan Setup
         click element                ${NEW_Tax_Plan}
Audit click
         Tax Plan Setup
         click element                ${AUDIT_BUTTON_TAX_PLAN}
         click element                ${AUDIT_DROP_TAX_PLAN}
Edit Click
         Tax Plan Setup
         click element                ${EDIT_BUTTON_TAX_PLAN}
ADD Formula
         Tax Plan Setup
         click element                ${VIEW_FORMULA}
         click element                ${ADD_FORMULA_BUTTTON}
#Fuction for generating random strings
Initialize Random Variables for Tax Plan cycle
         ${RANDOM_TAX_NAME}=        Generate random string           5
         Set global variable        ${RANDOM_TAX_NAME}
         ${RANDOM_TAX_CODE}=        Generate random string           4
         Set global variable        ${RANDOM_TAX_CODE}
         ${RANDOM_EDIT_NAME}=        Generate random string           15
         Set global variable        ${RANDOM_EDIT_NAME}


#Fuctions to give to main test keyword
Give input to Tax Plan cycle
         [Arguments]        ${NAME}       ${NEW_VERIFY}
         input text                       ${XPATH_TO_NAME_TAX_PLAN}          ${NAME}
         click element                    ${SAVE}
         wait until page contains         ${${NEW_VERIFY}}

#verification of the newly generated bill
Verification of Tax paln
         [Arguments]                  ${NAME}
         wait until page contains     ${NAME}
Audit for new tax plan
         [Arguments]                  ${NAME}
         Audit click
         wait until page contains     ${NAME}
Edit section for Tax Plan
         [Arguments]                  ${EDIT_NAME}  ${EDIT_VERIFY}
         Edit Click
         input text                   ${XPATH_TO_NAME_TAX_PLAN}         ${EDIT_NAME}
         click element                ${SAVE}
         wait until page contains     ${${EDIT_VERIFY}}
Edit verifictation
         [Arguments]     ${EDIT_NAME}
         Tax Plan Setup
         wait until page contains      ${EDIT_NAME}
Audit For Edit name
         [Arguments]     ${EDIT_NAME}  ${NAME}
         Tax Plan Setup
         Audit click
         wait until page contains      ${EDIT_NAME}
         wait until page contains      ${NAME}
Adding formula
         [Arguments]  ${TAX_FORMULA}
         ADD Formula
         Select From List By Label     ${XPATH_TO_FORMULA_TEXTBOX}     ${TAX_FORMULA}
         click element                 ${SAVE}
         wait until page contains      ${Success}
#Verification,audit and edit new tax plan if statement
Verify,audit and edit for IF new
         [Arguments]        ${NAME}    ${EDIT_NAME}  ${EDIT_VERIFY}
         Verification of Tax paln      ${NAME}
         Audit for new tax plan        ${NAME}
         Edit section for Tax Plan     ${EDIT_NAME}  ${EDIT_VERIFY}
         Run Keyword If  '${EDIT_VERIFY}'=='Pass'   Edit verify &Audit    ${EDIT_NAME}  ${NAME}

Add tax formula
         [Arguments]   ${TAX_FORMULA}  ${EDIT_VERIFY}  ${NEW_VERIFY}
         Run Keyword If  '${NEW_VERIFY}'=='Pass'   IF for the tax formula      ${TAX_FORMULA}  ${EDIT_VERIFY}

IF for the tax formula
         [Arguments]     ${TAX_FORMULA}  ${EDIT_VERIFY}
         Run Keyword If  '${EDIT_VERIFY}'=='Pass'   Adding formula        ${TAX_FORMULA}

#edit verification and audit verifiction
Edit verify &Audit
         [Arguments]            ${EDIT_NAME}  ${NAME}
         Tax Plan Setup
         Edit verifictation     ${EDIT_NAME}
         Audit For Edit name    ${EDIT_NAME}  ${NAME}



#main fuvction for the runner with single if
Edit,Verify&Audit Tax Plan
         [Arguments]   ${NAME}    ${EDIT_NAME}  ${EDIT_VERIFY}  ${NEW_VERIFY}
         Run Keyword If  '${NEW_VERIFY}'=='Pass'   Verify,audit and edit for IF new    ${NAME}  ${EDIT_NAME}  ${EDIT_VERIFY}