*** Settings ***
Library           Selenium2Library
Resource          ../Resources/Common_Resource.robot
Resource          ../Resources/Tax_Plan_Resource.robot
Resource          ../Location/Common_Location.robot
Resource           ../Location/Tax_Plan_Location.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To Tax Plan Website        #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New Tax Plan Generation      #keyword call for test fuction
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet5   #excel file



*** Test Cases ***
Tax Plan Test   ${NAME}   ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_VERIFY}  ${TAX_FORMULA}



*** Keywords ***
New Tax Plan Generation
      [Arguments]   ${NAME}   ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_VERIFY}  ${TAX_FORMULA}
      #reachning  till the new cycle page
      New Tax Plan cycle
      #Re-running the random string fuction for new set of values
      Initialize Random Variables for Tax Plan cycle
      #inputing new data
      Give input to Tax Plan cycle    ${NAME}  ${NEW_VERIFY}
      #Verify edit and Audit
      Edit,Verify&Audit Tax Plan    ${NAME}    ${EDIT_NAME}  ${EDIT_VERIFY}  ${NEW_VERIFY}
      #Adding tax formula
      Add tax formula   ${TAX_FORMULA}  ${EDIT_VERIFY}  ${NEW_VERIFY}