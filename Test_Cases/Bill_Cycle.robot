*** Settings ***
Library           Selenium2Library
Resource          ../Resources/Common_Resource.robot
Resource          ../Resources/Bill_Cycle_Resource.robot
Resource          ../Location/Common_Location.robot
Resource           ../Location/Bill_Cycle_Location.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To Bill Cycle Website          #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New Bill Generation       #keyword call for test fuction
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet1   #excel file




*** Test Cases ***
Bill_Cycle_Test     ${ALL_ARGUMENTS}





*** Keywords ***
New Bill Generation
      [Arguments]    ${NAME}  ${PERIODICITY}  ${DATE}  ${MONTH}  ${TYPE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_TYPE}  ${EDIT_VERIFY}
      #reachning  till the new cycle page
      New bill cycle
      #Re-running the random string fuction for new set of values
      Initialize Random Variables for Bill Cycle
      #inputing new data
      Give input to new bill cycle       ${NAME}     ${PERIODICITY}     ${DATE}    ${MONTH}       ${TYPE}
      #Waiting for confirmation
      wait until page contains           ${${NEW_VERIFY} }
      #Verification of new bill cycle in case of new bill generation
      Run Keyword If  '${NEW_VERIFY}'=='Pass'   Edit Verify &Audit  ${NAME}  ${PERIODICITY}  ${DATE}  ${TYPE}  ${EDIT_NAME}  ${EDIT_TYPE}  ${EDIT_VERIFY}



