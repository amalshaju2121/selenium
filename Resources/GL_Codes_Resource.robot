*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/GL_Codes_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet2   #excel file

*** Keywords ***

Login To GL Codes Website
         Login To website
         Initialize Random Variables for GL Code cycle   #Bringing the random name fuction to suit setup

#Required setup fuctions
GL_Codes_Setup
         Setup
         set selenium implicit wait            10s
         click element                         ${XPATH_TO_GL_CODES_BUTTON}
New GL Code cycle
         GL_Codes_Setup
         set selenium implicit wait            10s
         click element                         ${NEW_GL_CODES}
Edit GL Code cycle
         GL_Codes_Setup
         click element                         ${XPATH_TO_EDIT_BUTTON}
Audit click
         GL_Codes_Setup
         set selenium implicit wait            10s
         click element                         ${XPATH_TO AUDIT}
         set selenium implicit wait            10s
         click element                         ${XPATH_TO_DROPDOWN_BUTTON}
         set selenium implicit wait            10s


#Fuction for generating random strings
Initialize Random Variables for GL Code cycle
         ${RANDOM_CYCLE_NAME}=    Generate random string        15
         Set global variable      ${RANDOM_CYCLE_NAME}
         ${RANDOM_GL_CODE}=       Generate random string        4       [NUMBERS]
         Set global variable      ${RANDOM_GL_CODE}
         ${RANDOM_EDIT_NAME}=     Generate random string         15
         Set global variable      ${RANDOM_EDIT_NAME}

#Fuctions to give to main test keyword
Give input to GL Code cycle
         [Arguments]             ${GL_CODE_NAME}                  ${GL_CODE}
         input text              ${XPATH_TO_NAME_TEXTBOX}         ${GL_CODE_NAME}
         input text              ${XPATH_TO_CODE_TEXTBOX}         ${GL_CODE}
         click element           ${SAVE}
Verification
         [Arguments]             ${GL_CODE_NAME}     ${GL_CODE}
         GL_Codes_Setup
         wait until page contains             ${GL_CODE_NAME}
         wait until page contains             ${GL_CODE}

Auditing the GL_Codes
         [Arguments]      ${GL_CODE_NAME}     ${GL_CODE}
         Audit click
         wait until page contains             ${GL_CODE_NAME}
         wait until page contains             ${GL_CODE}
Editing section
         [Arguments]                ${GL_CODE_NEW_NAME}               ${EXPECTED_TEXT_TO_VERIFY}
         Edit GL Code cycle
         #inputing new edit data
         input text                 ${XPATH_TO_NEW_NAME_TEXTBOX}      ${GL_CODE_NEW_NAME}
         click element              ${SAVE}
         #Waiting for edit confirmation
         wait until page contains            ${${EXPECTED_TEXT_TO_VERIFY}}
         Reload Page
Edit verification
         [Arguments]         ${GL_CODE_NEW_NAME}
         GL_Codes_Setup
         wait until page contains            ${GL_CODE_NEW_NAME}
Audit check of edited GL Codes
         [Arguments]         ${GL_CODE_NEW_NAME}
         Audit click
         wait until page contains            ${GL_CODE_NEW_NAME}




#fuctions for If Statements
Edit Verify &Audit
         [Arguments]                ${GL_CODE_NAME}     ${GL_CODE}   ${GL_CODE_NEW_NAME}      ${EXPECTED_TEXT_TO_VERIFY}
         Verification               ${GL_CODE_NAME}     ${GL_CODE}
         Auditing the GL_Codes      ${GL_CODE_NAME}     ${GL_CODE}
         Editing section            ${GL_CODE_NEW_NAME}              ${EXPECTED_TEXT_TO_VERIFY}
         #verifing the edit bills in case of edit in bill
         Run Keyword If      '${EXPECTED_TEXT_TO_VERIFY}'=='Pass'          Edit Verification and Audit verifiction    ${GL_CODE_NEW_NAME}
Edit Verification and Audit verifiction
         [Arguments]                ${GL_CODE_NEW_NAME}
         Edit verification          ${GL_CODE_NEW_NAME}
         Audit check of edited GL Codes                  ${GL_CODE_NEW_NAME}


#Test case arguments
${ALL_ARGUMENTS}=     ${GL_CODE_NAME}    ${GL_CODE}      ${GL_CODE_NEW_NAME}     ${EXPECTED_TEXT_TO_VERIFY_NEW_GL_CODE}    ${EXPECTED_TEXT_TO_VERIFY}