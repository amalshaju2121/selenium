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
GL_Codes_Test       ${ALL_ARGUMENTS}



*** Keywords ***
New GL Codes Generation
      [Arguments]    ${GL_NAME}  ${GL_CODE}  ${EDIT_NAME}  ${NEW_VERIFY}  ${EDIT_VERIFY}
      #reachning  till the new cycle page
      New GL Code cycle
      #Re-running the random string fuction for new set of values
      Initialize Random Variables for GL Code cycle
      #inputing new data
      Give input to GL Code cycle      ${GL_NAME}     ${GL_CODE}    ${NEW_VERIFY}
      #Verifiy audit edit
      Edit Verify &Audit      ${GL_NAME}  ${GL_CODE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_VERIFY}


