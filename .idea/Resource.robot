*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ./location.robot
Library    DataDriver     ../TestData/bill.xlsx   sheet_name=Sheet1   #excel file
*** Keywords ***
#suit setup files & Teardown files
Login To website
         open browser                    ${URL}     ${browser}
         set selenium implicit wait      10s
         maximize browser window
         input text                      ${XPATH_TO_USERNAME_TEXTBOX}          ${USER_ID}
         input text                      ${XPATH_TO_PASSWORD_TEXTBOX}          ${PASSWORD}
         click element                   ${LOGIN_SUBMIT BUTTON}
Close Browsers
         close all browsers



#Required setup fuctions
Setup
         Reload Page

         click element               ${CONFIGURATION}
         click element               ${BILLING_CYCLE}
New bill cycle
         Setup
         click element               ${NEW_BILL_CYCLE}
Edit bill cycle
         Setup
         click element               ${EDIT_BILL_BUTTON}
Audit click
         Setup
         click element                         ${XPATH_TO_AUDIT_BUTTON}
         set selenium implicit wait            10s
         click element                         ${XPATH_TO_DROPDOWN_BUTTON}
         set selenium implicit wait            10s



#Fuctions to give to main test keyword
Give input to new bill cycle
         [Arguments]    ${CYCLE_NAME}     ${PERIODICITY}    ${START_DATE}    ${START_MONTH}    ${CUSTOMER_TYPE}
         input text                       ${XPATH_TO_CYCLE_NAME_TEXTBOX}            ${CYCLE_NAME}
         Select From List By Label        ${XPATH_TO_PERIODICITY_TEXTBOX}           ${PERIODICITY}
         Select From List By Label        ${XPATH_TO_START_DATE_TEXTBOX}            ${START_DATE}
         Select From List By Label        ${XPATH_TO_START_MONTH_TEXTBOX}           ${START_MONTH}
         Select From List By Label        ${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}         ${CUSTOMER_TYPE}
         click element                    ${SAVE}
Verification
         [Arguments]    ${CYCLE_NAME}     ${PERIODICITY}    ${START_DATE}     ${CUSTOMER_TYPE}
         Setup
         wait until page contains         ${CYCLE_NAME}
         Element Should Contain           ${XPATH_TO_VERIFY_PERIODICITY}            ${PERIODICITY}
         Element Should Contain           ${XPATH_TO_VERIFY_START_DATE}             ${START_DATE}
         Element Should Contain           ${XPATH_TO_VERIFY_CUSTOMER_TYPE}          ${CUSTOMER_TYPE}
Auditing the new bill
         [Arguments]      ${CYCLE_NAME}     ${CUSTOMER_TYPE}
         Audit click
         wait until page contains                ${CYCLE_NAME}
         wait until page contains                ${CUSTOMER_TYPE}
Editing section
         [Arguments]    ${NEW_CYCLE_NAME}    ${NEW_CUSTOMER_TYPE}      ${EXPECTED_TEXT_TO_VERIFY}
         Edit bill cycle
         #inputing new edit data
         input text                        ${XPATH_TO_CYCLE_NAME_TEXTBOX}           ${NEW_CYCLE_NAME}
         Select From List By Label         ${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}        ${NEW_CUSTOMER_TYPE}
         click element                     ${SAVE}
         #Waiting for edit confirmation
         wait until page contains          ${${EXPECTED_TEXT_TO_VERIFY}}
         Reload Page



#fuctions for If Statements
Verify,Audit and Edit the newly genrated bill
         [Arguments]         ${CYCLE_NAME}         ${PERIODICITY}          ${START_DATE}          ${CUSTOMER_TYPE}     ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}     ${EXPECTED_TEXT_TO_VERIFY}
         Verification        ${CYCLE_NAME}         ${PERIODICITY}          ${START_DATE}          ${CUSTOMER_TYPE}
         Auditing the new bill      ${CYCLE_NAME}         ${CUSTOMER_TYPE}
         Editing section            ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}    ${EXPECTED_TEXT_TO_VERIFY}
Edit verification
         [Arguments]     ${NEW_CYCLE_NAME}    ${NEW_CUSTOMER_TYPE}
         Setup
         Element Should Contain          ${XPATH_TO_VERIFY_NAME}                    ${NEW_CYCLE_NAME}
         Element Should Contain          ${XPATH_TO_VERIFY_CUSTOMER_TYPE}           ${NEW_CUSTOMER_TYPE}



#final audit
Audit check of edited bill
         [Arguments]      ${NEW_CYCLE_NAME}      ${NEW_CUSTOMER_TYPE}      ${CYCLE_NAME}     ${CUSTOMER_TYPE}
         Audit click
         wait until page contains                ${NEW_CYCLE_NAME}
         wait until page contains                ${NEW_CUSTOMER_TYPE}
         wait until page contains                ${CYCLE_NAME}
         wait until page contains                ${CUSTOMER_TYPE}

ranton
${random_string}=    Generate Random String    12    [LOWER]