*** Settings ***
Library           Selenium2Library
Resource          ../Resources/Common_Resource.robot
Resource          ../Resources/GL_Codes_Resource.robot
Resource          ../Location/Common_Location.robot
Resource           ../Location/GL_Codes_Location.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To GL Codes Website          #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New GL Codes Generation      #keyword call for test fuction
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet2   #excel file


*** Test Cases ***
GL_Codes_Test           ${ALL_ARGUMENTS}



*** Keywords ***
New GL Codes Generation
        [Arguments]     ${GL_CODE_NAME}     ${GL_CODE}      ${GL_CODE_NEW_NAME}     ${EXPECTED_TEXT_TO_VERIFY_NEW_GL_CODE}     ${EXPECTED_TEXT_TO_VERIFY}
         #Re-running the random string fuction for new set of values
        Initialize Random Variables for GL Code cycle
        #reachning  till the new cycle page
        New GL Code cycle
        #inputing new data
        Give input to GL Code cycle       ${GL_CODE_NAME}     ${GL_CODE}
        #Waiting for confirmation
        wait until page contains          ${${EXPECTED_TEXT_TO_VERIFY_NEW_GL_CODE}}
        #Verification of new bill cycle in case of new bill generation
        Run Keyword If      '${EXPECTED_TEXT_TO_VERIFY_NEW_GL_CODE}'=='Pass'    Verify,Audit and Edit          ${GL_CODE_NAME}     ${GL_CODE}      ${GL_CODE_NEW_NAME}     ${EXPECTED_TEXT_TO_VERIFY}
         #verifing the edit bills in case of edit in bill
        Run Keyword If      '${EXPECTED_TEXT_TO_VERIFY}'=='Pass'                Edit Verification and Audit    ${GL_CODE_NEW_NAME}



