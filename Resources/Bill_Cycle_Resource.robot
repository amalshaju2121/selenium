*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Bill_Cycle_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet1   #excel file



*** Keywords ***

Login To Bill Cycle Website
         Login To website
         Initialize Random Variables for Bill Cycle    #Bringing the random name fuction to suit setup

#Required setup fuctions
Bill_Cycle_Setup
         Setup
         click element               ${BILLING_CYCLE}
New bill cycle
         Bill_Cycle_Setup
         click element               ${NEW_BILL_CYCLE}
Edit bill cycle
         Bill_Cycle_Setup
         click element               ${EDIT_BUTTON}
Audit click
         Bill_Cycle_Setup
         click element                         ${XPATH_TO_AUDIT_BUTTON}
         click element                         ${XPATH_TO_DROPDOWN_BUTTON}


#Fuction for generating random strings
Initialize Random Variables for Bill Cycle
         ${RANDOM_CYCLE_NAME}=   Generate random string        15
         Set global variable     ${RANDOM_CYCLE_NAME}
         ${RANDOM_EDIT_NAME}=   Generate random string         15
         Set global variable     ${RANDOM_EDIT_NAME}



#Fuctions to give to main test keyword
Give input to new bill cycle
         [Arguments]      ${NAME}     ${PERIODICITY}     ${DATE}     ${MONTH}       ${TYPE}       ${NEW_VERIFY}
         input text                       ${XPATH_TO_CYCLE_NAME_TEXTBOX}            ${NAME}
         Select From List By Label        ${XPATH_TO_PERIODICITY_TEXTBOX}           ${PERIODICITY}
         Select From List By Label        ${XPATH_TO_START_DATE_TEXTBOX}            ${DATE}
         Select From List By Label        ${XPATH_TO_START_MONTH_TEXTBOX}           ${MONTH}
         Select From List By Label        ${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}         ${TYPE}
         click element                    ${SAVE}
         #Waiting for confirmation
         wait until page contains         ${${NEW_VERIFY}}
Verification
         [Arguments]    ${NAME}     ${PERIODICITY}    ${DATE}     ${TYPE}
         Bill_Cycle_Setup
         wait until page contains         ${NAME}
         wait until page contains         ${PERIODICITY}
         wait until page contains         ${DATE}
         wait until page contains         ${TYPE}
Auditing the new bill
         [Arguments]      ${NAME}         ${TYPE}
         Audit click
         wait until page contains             ${NAME}
         wait until page contains             ${TYPE}
Editing section
         [Arguments]       ${EDIT_NAME}       ${EDIT_TYPE}       ${EDIT_VERIFY}
         Edit bill cycle
         #inputing new edit data
         input text                           ${XPATH_TO_CYCLE_NAME_TEXTBOX}           ${EDIT_NAME}
         Select From List By Label            ${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}        ${EDIT_TYPE}
         click element                        ${SAVE}
         #Waiting for edit confirmation
         wait until page contains             ${${EDIT_VERIFY}}

Edit verification
         [Arguments]        ${EDIT_NAME}      ${EDIT_TYPE}
         Bill_Cycle_Setup
         Element Should Contain               ${XPATH_TO_VERIFY_NAME}                    ${EDIT_NAME}
         Element Should Contain               ${XPATH_TO_VERIFY_CUSTOMER_TYPE}           ${EDIT_TYPE}

Audit check of edited bill
         [Arguments]     ${NAME}     ${TYPE}     ${EDIT_NAME}      ${EDIT_TYPE}
         Audit click
         wait until page contains                ${NAME}
         wait until page contains                ${TYPE}
         wait until page contains                ${EDIT_NAME}
         wait until page contains                ${EDIT_TYPE}



#fuctions for If Statements
Edit Verify &Audit for IF
         [Arguments]                ${NAME}   ${PERIODICITY}   ${DATE}  ${TYPE}  ${EDIT_NAME}  ${EDIT_TYPE}  ${EDIT_VERIFY}
         Verification               ${NAME}   ${PERIODICITY}   ${DATE}  ${TYPE}
         Auditing the new bill      ${NAME}   ${TYPE}
         Editing section            ${EDIT_NAME}     ${EDIT_TYPE}     ${EDIT_VERIFY}
         #verifing the edit bills in case of edit in bill
         Run Keyword If   '${EDIT_VERIFY}'=='Pass'   Edit& Audit verifiction   ${NAME}  ${TYPE}  ${EDIT_NAME}  ${EDIT_TYPE}
Edit& Audit verifiction
         [Arguments]        ${NAME}     ${TYPE}        ${EDIT_NAME}      ${EDIT_TYPE}
         Edit verification              ${EDIT_NAME}   ${EDIT_TYPE}
         Audit check of edited bill     ${NAME}     ${TYPE}     ${EDIT_NAME}    ${EDIT_TYPE}

#main IF statement
Edit Verify &Audit
         [Arguments]   ${NAME}  ${PERIODICITY}  ${DATE}  ${TYPE}  ${EDIT_NAME}  ${EDIT_TYPE}  ${EDIT_VERIFY}  ${NEW_VERIFY}
         Run Keyword If  '${NEW_VERIFY}'=='Pass'   Edit Verify &Audit for IF   ${NAME}  ${PERIODICITY}  ${DATE}  ${TYPE}  ${EDIT_NAME}  ${EDIT_TYPE}  ${EDIT_VERIFY}


#Test case arguments
${ALL_ARGUMENTS}=   ${NAME}  ${PERIODICITY}  ${DATE}  ${MONTH}  ${TYPE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_TYPE}  ${EDIT_VERIFY}