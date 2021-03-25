*** Settings ***
Library           Selenium2Library
Resource          ./Resource.robot
Resource          ./location.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To website          #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New Bill Generation       #keyword call for test fuction
Library    DataDriver     ../TestData/bill.xlsx   sheet_name=Sheet1   #excel file




*** Test Cases ***
first test    ${CYCLE_NAME}  ${PERIODICITY}    ${START_DATE}   ${START_MONHT}   ${CUSTOMER_TYPE}   ${NEW_CYCLE_NAME}   ${NEW_CUSTOMER_TYPE}         ${EXPECTED_TEXT_TO_VERIFY}      ${EXPECTED_TEXT_TO_VERIFY_NEW_BILL}




*** Keywords ***

New Bill Generation
         [Arguments]      ${CYCLE_NAME}     ${PERIODICITY}    ${START_DATE}     ${START_MONTH}    ${CUSTOMER_TYPE}     ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}     ${EXPECTED_TEXT_TO_VERIFY}      ${EXPECTED_TEXT_TO_VERIFY_NEW_BILL}
         New bill cycle      #reachning  till the new cycle page
         Initialize Random Variables     #Re-running the random string fuction for new set of values
         #inputing new data
         Give input to new bill cycle       ${CYCLE_NAME}     ${PERIODICITY}     ${START_DATE}    ${START_MONTH}       ${CUSTOMER_TYPE}
         #Waiting for confirmation
         wait until page contains           ${${EXPECTED_TEXT_TO_VERIFY_NEW_BILL}}
         #Verification of new bill cycle in case of new bill generation
         Run Keyword If      '${EXPECTED_TEXT_TO_VERIFY_NEW_BILL}'=='Pass'      Verify,Audit and Edit the newly genrated bill          ${CYCLE_NAME}          ${PERIODICITY}          ${START_DATE}             ${CUSTOMER_TYPE}    ${NEW_CYCLE_NAME}     ${NEW_CUSTOMER_TYPE}      ${EXPECTED_TEXT_TO_VERIFY}
         #verifing the edit bills in case of edit in bill
         Run Keyword If      '${EXPECTED_TEXT_TO_VERIFY}'=='Pass'               Edit Verification and Audit      ${NEW_CYCLE_NAME}       ${NEW_CUSTOMER_TYPE}      ${CYCLE_NAME}       ${CUSTOMER_TYPE}


