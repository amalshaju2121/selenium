*** Settings ***
Library           Selenium2Library
Resource          ../Resources/Common_Resource.robot
Resource          ../Resources/Tax_Formula_Resource.robot
Resource          ../Location/Common_Location.robot
Resource           ../Location/Tax_Formula_Location.robot
Library           ExcelLibrary
Library           String
Suite Setup       Login To Tax Formula Website          #suit setup till the bill gernaration page
Suite Teardown    close browsers
Test Template     New Tax Formula Generation      #keyword call for test fuction
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet4   #excel file




*** Test Cases ***

Tax Formula Test     ${ALL_ARGUMENTS_TAX_FORMULA}

*** Keywords ***
New Tax Formula Generation
      [Arguments]     ${CODE}  ${NAME}  ${TAX_PLAN}  ${GL_CODE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_TAX}  ${EDIT_VERIFY}
      #reachning  till the new cycle page
      New Tax Formula cycle
      #Re-running the random string fuction for new set of values
      Initialize Random Variables for Tax Formula cycle
      #inputing new data
      Give input to Tax Formula cycle      ${CODE}  ${NAME}  ${TAX_PLAN}  ${GL_CODE}  ${NEW_VERIFY}
      #Verifiy audit edit
      Edit Verify &Audit      ${CODE}  ${NAME}  ${TAX_PLAN}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_TAX}  ${EDIT_VERIFY}
