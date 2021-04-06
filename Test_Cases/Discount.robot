*** Settings ***
Library           Selenium2Library
Resource          ../Resources/Common_Resource.robot
Resource          ../Resources/Discount_Resource.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To Discounts Website         #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New Discount Generation            #keyword call for test fuction
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=DISCOUNTS   #excel file


*** Test Cases ***
Discounts Test    ${ALL_DISCOUNT_ARGUMENTS}


*** Keywords ***
New Discount Generation
    [Arguments]   ${DIS_NAME}  ${DURATION}  ${DUR_VALUE}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${TARGET}  ${APP_FOR}  ${COUNTED_TOWARDS}  ${SLAB_TYPE}  ${MIN_SLAB}  ${MAX_SLAB}  ${DIS_SLAB}  ${NEW_DIS_VERIFY}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}
    New Discounts cycle
    #Re-running the random string fuction for new set of values
    Initialize Random Variables for Discounts cycle
    #inputing new data
    Give input to Discounts cycle   ${DIS_NAME}  ${DURATION}  ${DUR_VALUE}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${TARGET}  ${APP_FOR}  ${COUNTED_TOWARDS}  ${SLAB_TYPE}  ${MIN_SLAB}  ${MAX_SLAB}  ${DIS_SLAB}  ${NEW_DIS_VERIFY}
    #Verification of new bill cycle in case of new bill generation
    Edit Verify & Audit Discount    ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}  ${NEW_DIS_VERIFY}
    #Viewing & Launching the cycle
    View and Launch the cycle       ${NEW_DIS_VERIFY}