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
         click element                         ${XPATH_TO_GL_CODES_BUTTON}
New GL Code cycle
         GL_Codes_Setup
         click element                         ${NEW_GL_CODES}
Edit GL Code cycle
         GL_Codes_Setup
         click element                         ${XPATH_TO_EDIT_BUTTON}
Audit click
         GL_Codes_Setup
         click element                         ${XPATH_TO AUDIT}
         click element                         ${XPATH_TO_DROPDOWN_BUTTON}



#Fuction for generating random strings
Initialize Random Variables for GL Code cycle
         ${RANDOM_CYCLE_NAME}=    Generate random string        5
         Set global variable      ${RANDOM_CYCLE_NAME}
         ${RANDOM_GL_CODE}=       Generate random string        4       [NUMBERS]
         Set global variable      ${RANDOM_GL_CODE}
         ${RANDOM_EDIT_NAME}=     Generate random string        13
         Set global variable      ${RANDOM_EDIT_NAME}

#Fuctions to give to main test keyword
Give input to GL Code cycle
         [Arguments]             ${GL_NAME}       ${GL_CODE}     ${NEW_VERIFY}
         input text              ${XPATH_TO_NAME_TEXTBOX}          ${GL_NAME}
         input text              ${XPATH_TO_CODE_TEXTBOX}          ${GL_CODE}
         click element           ${SAVE}
         wait until page contains         ${${NEW_VERIFY}}
Verification
         [Arguments]             ${GL_NAME}        ${GL_CODE}
         GL_Codes_Setup
         wait until page contains            ${GL_NAME}
         wait until page contains            ${GL_CODE}

Auditing the GL_Codes
         [Arguments]         ${GL_NAME}      ${GL_CODE}
         Audit click
         wait until page contains            ${GL_NAME}
         wait until page contains            ${GL_CODE}
Editing section
         [Arguments]                ${EDIT_NAME}                     ${EDIT_VERIFY}
         Edit GL Code cycle
         #inputing new edit data
         input text                 ${XPATH_TO_NEW_NAME_TEXTBOX}      ${EDIT_NAME}
         click element              ${SAVE}
         #Waiting for edit confirmation
         wait until page contains            ${${EDIT_VERIFY}}
         Reload Page
Edit verification
         [Arguments]                         ${EDIT_NAME}
         GL_Codes_Setup
         wait until page contains            ${EDIT_NAME}
Audit check of edited GL Codes
         [Arguments]                         ${EDIT_NAME}
         Audit click
         wait until page contains            ${EDIT_NAME}




#fuctions for If Statements
Edit Verify &Audit for IF
         [Arguments]                ${GL_NAME}      ${GL_CODE}   ${EDIT_NAME}      ${EDIT_VERIFY}
         Verification               ${GL_NAME}      ${GL_CODE}
         Auditing the GL_Codes      ${GL_NAME}      ${GL_CODE}
         Editing section            ${EDIT_NAME}    ${EDIT_VERIFY}
         #verifing the edit bills in case of edit in bill
         Run Keyword If      '${EDIT_VERIFY}'=='Pass'       Edit Verification and Audit verifiction    ${EDIT_NAME}
Edit Verification and Audit verifiction
         [Arguments]                ${EDIT_NAME}
         Edit verification          ${EDIT_NAME}
         Audit check of edited GL Codes            ${EDIT_NAME}

Edit Verify &Audit
         [Arguments]   ${GL_NAME}  ${GL_CODE}  ${NEW_VERIFY}  ${EDIT_NAME}  ${EDIT_VERIFY}
         Run Keyword If  '${NEW_VERIFY}'=='Pass'   Edit Verify &Audit for IF   ${GL_NAME}  ${GL_CODE}  ${EDIT_NAME}  ${EDIT_VERIFY}

#Test case arguments
${ALL_ARGUMENTS}=   ${GL_NAME}  ${GL_CODE}  ${EDIT_NAME}    ${NEW_VERIFY}    ${EDIT_VERIFY}