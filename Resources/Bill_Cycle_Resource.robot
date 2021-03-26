*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Bill_Cycle_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/bill.xlsx   sheet_name=Sheet1   #excel file



*** Keywords ***

Login To Bill Cycle Website
         Login To website
         Initialize Random Variables for Bill Cycle   #Bringing the random name fuction to suit setup

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
         set selenium implicit wait            10s
         click element                         ${XPATH_TO_DROPDOWN_BUTTON}
         set selenium implicit wait            10s


#Fuction for generating random strings
Initialize Random Variables for Bill Cycle
         ${RANDOM_CYCLE_NAME}=   Generate random string        15
         Set global variable     ${RANDOM_CYCLE_NAME}
         ${RANDOM_EDIT_NAME}=   Generate random string         15
         Set global variable     ${RANDOM_EDIT_NAME}



#Fuctions to give to main test keyword
Give input to new bill cycle
         [Arguments]    ${CYCLE_NAME}     ${PERIODICITY}       ${START_DATE}        ${START_MONTH}       ${CUSTOMER_TYPE}
         input text                       ${XPATH_TO_CYCLE_NAME_TEXTBOX}            ${CYCLE_NAME}
         Select From List By Label        ${XPATH_TO_PERIODICITY_TEXTBOX}           ${PERIODICITY}
         Select From List By Label        ${XPATH_TO_START_DATE_TEXTBOX}            ${START_DATE}
         Select From List By Label        ${XPATH_TO_START_MONTH_TEXTBOX}           ${START_MONTH}
         Select From List By Label        ${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}         ${CUSTOMER_TYPE}
         click element                    ${SAVE}
Verification
         [Arguments]    ${CYCLE_NAME}     ${PERIODICITY}    ${START_DATE}     ${CUSTOMER_TYPE}
         Bill_Cycle_Setup
         wait until page contains         ${CYCLE_NAME}
         Element Should Contain           ${XPATH_TO_VERIFY_PERIODICITY}            ${PERIODICITY}
         Element Should Contain           ${XPATH_TO_VERIFY_START_DATE}             ${START_DATE}
         Element Should Contain           ${XPATH_TO_VERIFY_CUSTOMER_TYPE}          ${CUSTOMER_TYPE}
Auditing the new bill
         [Arguments]      ${CYCLE_NAME}          ${CUSTOMER_TYPE}
         Audit click
         wait until page contains                ${CYCLE_NAME}
         wait until page contains                ${CUSTOMER_TYPE}
Editing section
         [Arguments]      ${NEW_CYCLE_NAME}      ${NEW_CUSTOMER_TYPE}      ${EXPECTED_TEXT_TO_VERIFY}
         Edit bill cycle
         #inputing new edit data
         input text                           ${XPATH_TO_CYCLE_NAME_TEXTBOX}           ${NEW_CYCLE_NAME}
         Select From List By Label            ${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}        ${NEW_CUSTOMER_TYPE}
         click element                        ${SAVE}
         #Waiting for edit confirmation
         wait until page contains             ${${EXPECTED_TEXT_TO_VERIFY}}
         Reload Page
Edit verification
         [Arguments]     ${NEW_CYCLE_NAME}    ${NEW_CUSTOMER_TYPE}
         Bill_Cycle_Setup
         Element Should Contain               ${XPATH_TO_VERIFY_NAME}                    ${NEW_CYCLE_NAME}
         Element Should Contain               ${XPATH_TO_VERIFY_CUSTOMER_TYPE}           ${NEW_CUSTOMER_TYPE}

Audit check of edited bill
         [Arguments]      ${NEW_CYCLE_NAME}      ${NEW_CUSTOMER_TYPE}      ${CYCLE_NAME}     ${CUSTOMER_TYPE}
         Audit click
         wait until page contains                ${NEW_CYCLE_NAME}
         wait until page contains                ${NEW_CUSTOMER_TYPE}
         wait until page contains                ${CYCLE_NAME}
         wait until page contains                ${CUSTOMER_TYPE}


#fuctions for If Statements
Verify,Audit and Edit the newly genrated bill
         [Arguments]                ${CYCLE_NAME}         ${PERIODICITY}          ${START_DATE}          ${CUSTOMER_TYPE}     ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}     ${EXPECTED_TEXT_TO_VERIFY}
         Verification               ${CYCLE_NAME}         ${PERIODICITY}          ${START_DATE}          ${CUSTOMER_TYPE}
         Auditing the new bill      ${CYCLE_NAME}         ${CUSTOMER_TYPE}
         Editing section            ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}    ${EXPECTED_TEXT_TO_VERIFY}
Edit Verification and Audit
         [Arguments]                    ${NEW_CYCLE_NAME}      ${NEW_CUSTOMER_TYPE}      ${CYCLE_NAME}     ${CUSTOMER_TYPE}
         Edit verification              ${NEW_CYCLE_NAME}      ${NEW_CUSTOMER_TYPE}
         Audit check of edited bill     ${NEW_CYCLE_NAME}      ${NEW_CUSTOMER_TYPE}      ${CYCLE_NAME}     ${CUSTOMER_TYPE}

${ALL_ARGUMENTS}=     ${CYCLE_NAME}   ${PERIODICITY}    ${START_DATE}   ${START_MONTH}   ${CUSTOMER_TYPE}   ${NEW_CYCLE_NAME}   ${NEW_CUSTOMER_TYPE}  ${EXPECTED_TEXT_TO_VERIFY}    ${EXPECTED_TEXT_TO_VERIFY_NEW_BILL}
${NEW_BILL_ARGUMENTS}=      ${CYCLE_NAME}     ${PERIODICITY}     ${START_DATE}    ${START_MONTH}       ${CUSTOMER_TYPE}
${NEW_BILL_EDIT_ARGUMENTS}=     ${CYCLE_NAME}          ${PERIODICITY}          ${START_DATE}             ${CUSTOMER_TYPE}    ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}      ${EXPECTED_TEXT_TO_VERIFY}
${NEW_BILL_AUDIT_ARGUMENTS}=     ${NEW_CYCLE_NAME}       ${NEW_CUSTOMER_TYPE}      ${CYCLE_NAME}       ${CUSTOMER_TYPE}