*** Settings ***
Library           Selenium2Library
Resource          ../Resources/Common_Resource.robot
Resource          ../Resources/Charges_Resource.robot
Resource          ../Location/Common_Location.robot
Resource          ../Location/Charges_Location.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To Charges Website         #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New Charges Generation     #keyword call for test fuction
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet3   #excel file

*** Test Cases ***
Charges_Test     ${NAME}     ${TYPE}       ${GL_CODE}      ${TAX_PLAN}   ${NEW_VERIFY} ${EDIT_NAME}    ${EDIT_TAX}   ${TYPE}     ${EDIT_VERIFY}          ${EDIT_GL_CODE}


*** Keywords ***
New Charges Generation
        [Arguments]     ${NAME}     ${TYPE}       ${GL_CODE}      ${TAX_PLAN}   ${NEW_VERIFY}  ${EDIT_NAME}    ${EDIT_TAX}   ${TYPE}     ${EDIT_VERIFY}          ${EDIT_GL_CODE}
        #reachning  till the new cycle page
        New Charges cycle
#        #Re-running the random string fuction for new set of values
        Initialize Random Variables for Charges cycle
#        #inputing new data
        Give input to Charges cycle     ${NAME}     ${TYPE}       ${GL_CODE}      ${TAX_PLAN}   ${NEW_VERIFY}
        Verification         ${NAME}    ${TYPE}       ${GL_CODE}


