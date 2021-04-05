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
Charges_Test   ${ALL_CHARGER_ARGUMENTS}

*** Keywords ***
New Charges Generation
    [Arguments]   ${NAME}  ${GL_CODE}  ${TYPE}  ${TAX_PLAN}  ${NEW_VERIFY}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${EDIT_NAME}  ${EDIT_VERIFY}  ${EDIT_GL_CODE}  ${EDIT_TAX_PLAN}  ${EDIT_DIS_GL_CODE}  ${EDIT_DIS_APP_CODE}
    #reachning  till the new cycle page
    New Charges cycle
    #Re-running the random string fuction for new set of values
    Initialize Random Variables for Charges cycle
    #inputing new data
    Give input to Charges cycle   ${NAME}  ${TYPE}  ${GL_CODE}  ${TAX_PLAN}  ${NEW_VERIFY}  ${DIS_GL_CODE}  ${DIS_APP_CODE}
    #Verification of new bill cycle in case of new bill generation
    Edit Verify & Audit   ${NAME}  ${TYPE}  ${GL_CODE}  ${DIS_GL_CODE}  ${DIS_APP_CODE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_VERIFY}  ${EDIT_GL_CODE}  ${EDIT_TAX_PLAN}  ${TAX_PLAN}  ${EDIT_DIS_GL_CODE}  ${EDIT_DIS_APP_CODE}


