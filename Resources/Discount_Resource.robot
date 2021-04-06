*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Discount_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=DISCOUNTS   #excel file

*** Keywords ***
Login To Discounts Website
      Login To website
      Initialize Random Variables for Discounts cycle   #Bringing the random name fuction to suit setup

#Required setup fuctions
Discounts Setup
      Setup
      click element                        ${XPATH_TO_DISCOUNTS}
New Discounts cycle
      Discounts Setup
      click element                        ${XPATH_TO_NEW_CYCLE_DISCoUNT}
Audit Discounts click
      Discounts Setup
      click element                        ${XPATH_TO_DIS_AUDIT_CLICK}
      click element                        ${XPATH_TO_DIS_AUDIT_DROPDOWN}
Edit Discount click
      Discounts Setup
      click element                        ${XPATH_TO_DIS_EDIT_CLICK}
View Discount click
      Discounts Setup
      click element                        ${XPATH_TO_DIS_VIEW_CLICK}
Launch discount click
      Discounts Setup
      click element                        ${XPATH_TO_DIS_LAUNCH_CLICK}

#Fuction for generating random strings
Initialize Random Variables for Discounts cycle
      ${RANDOM_DIS_NAME}=         Generate random string        5
      Set global variable         ${RANDOM_DIS_NAME}
      ${RANDOM_EDIT_DIS_NAME}=    Generate random string        4
      Set global variable         ${RANDOM_EDIT_DIS_NAME}
      ${RANDOM_APP_FOR}=          Generate random string        7
      Set global variable         ${RANDOM_APP_FOR}
      ${RANDOM_EDIT_APP_FOR}=     Generate random string        8
      Set global variable         ${RANDOM_EDIT_APP_FOR}



#Fuctions to give to main test keyword
Give input to Discounts cycle
      [Arguments]   ${DIS_NAME}  ${DURATION}  ${DUR_VALUE}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${TARGET}  ${APP_FOR}  ${COUNTED_TOWARDS}  ${SLAB_TYPE}  ${MIN_SLAB}  ${MAX_SLAB}  ${DIS_SLAB}  ${NEW_DIS_VERIFY}
      Wait Until Element Is Visible  ${XPATH_TO_DISC_NAME}
      input text                     ${XPATH_TO_DISC_NAME}      ${DIS_NAME}
      Select From List By Label      ${XPATH_TO_DURATION}       ${DURATION}
      Run Keyword If                '${DURATION}'=='Fixed Period'       Duration unit      ${DUR_VALUE}
      Select From List By Label      ${XPATH_TO_DIS_GL_CODE}    ${DISC_GL_CODE}
      Select From List By Label      ${XPATH_TO_DIS_ORIGIN}     ${DIS_ORIGIN}
      Select From List By Label      ${XPATH_TO_DIS_TARGET}     ${TARGET}
      input text                     ${XPATH_TO_DIS_APP_FOR}    ${APP_FOR}
      Run Keyword If       '${COUNTED_TOWARDS}'=='SELECTED'     Run the selected bills
      Select From List By Label      ${XPATH_TO_DIS_SLAB_TYPE}  ${SLAB_TYPE}
      Run Keyword If       '${SLAB_TYPE}'=='Tiered Fixed'       Slab mini fuction for If   ${MIN_SLAB}
      Run Keyword If       '${SLAB_TYPE}'=='Volume Fixed'       Slab mini fuction for If   ${MIN_SLAB}
      input text                     ${XPATH_TO_DIS_MAX_SLAB}   ${MAX_SLAB}
      input text                     ${XPATH_TO_DIS_DIS_SLAB}   ${DIS_SLAB}
      click element                  ${SUBMIT_BUTTON}
      wait until page contains       ${NEW_DIS_VERIFY}

#Verification for the newly generated bill
New discount Verification
      [Arguments]          ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}   ${DIS_ORIGIN}
      Discounts Setup
      wait until page contains          ${DIS_NAME}
      wait until page contains          ${APP_FOR}
      wait until page contains          ${DISC_GL_CODE}
      wait until page contains          ${DIS_ORIGIN}

#Auditing the newly generated discount cycle
Audit for new discount cycle
      [Arguments]       ${DIS_NAME}     ${APP_FOR}   ${DISC_GL_CODE}   ${DIS_ORIGIN}
      Audit Discounts click
      wait until page contains          ${DIS_NAME}
      wait until page contains          ${APP_FOR}
      wait until page contains          ${DISC_GL_CODE}
      wait until page contains          ${DIS_ORIGIN}

#Beging of edit section
Edit Discount section
      [Arguments]   ${EDIT_DIS_NAME}   ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}
      Edit Discount click
      Wait Until Element Is Visible    ${XPATH_TO_DISC_NAME}
      input text                       ${XPATH_TO_DISC_NAME}        ${EDIT_DIS_NAME}
      input text                       ${XPATH_TO_DIS_APP_FOR}      ${EDIT_APP_FOR}
      Select From List By Label        ${XPATH_TO_DIS_GL_CODE}      ${EDIT_DISC_GL_CODE}
      click element                    ${SUBMIT_BUTTON}
      wait until page contains         ${EDIT_DIS_VERIFY}

#verifying the edited discount cycle
Edit verification discount
      [Arguments]    ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}   ${EDIT_DISC_GL_CODE}
      Discounts Setup
      wait until page contains         ${EDIT_DIS_NAME}
      wait until page contains         ${EDIT_APP_FOR}
      wait until page contains         ${EDIT_DISC_GL_CODE}

#Auditing the full cycle
Audit for edit discount section
      [Arguments]     ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}
      Audit Discounts click
      wait until page contains         ${DIS_NAME}
      wait until page contains         ${APP_FOR}
      wait until page contains         ${DISC_GL_CODE}
      wait until page contains         ${DIS_ORIGIN}
      wait until page contains         ${EDIT_DIS_NAME}
      wait until page contains         ${EDIT_APP_FOR}
      wait until page contains         ${EDIT_DISC_GL_CODE}


#Launch verification
Launch verification
      Discounts Setup
      wait until page contains         ${LAUNCHED}
#view abd launch to runner for if
View and Launch the cycle for IF
      View Discount click
      Launch discount click
      Launch verification


#fuctions for If Statements
Edit Verify &Audit for Discount IF
      [Arguments]   ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}
      New discount Verification       ${DIS_NAME}    ${APP_FOR}       ${DISC_GL_CODE}   ${DIS_ORIGIN}
      Audit for new discount cycle    ${DIS_NAME}    ${APP_FOR}       ${DISC_GL_CODE}   ${DIS_ORIGIN}
      Edit Discount section    ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}
      Run Keyword If    '${EDIT_DIS_VERIFY}'=='Success'    Edit &Audit Verification Discount   ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}

#Verification for edit if
Edit &Audit Verification Discount
      [Arguments]     ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}
      Edit verification discount        ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}
      Audit for edit discount section   ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}

#main if for the runner
Edit Verify & Audit Discount
      [Arguments]   ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}  ${NEW_DIS_VERIFY}
      Run Keyword If    '${NEW_DIS_VERIFY}'=='Success'   Edit Verify &Audit for Discount IF   ${DIS_NAME}  ${APP_FOR}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}


#IF statements for the input data
Duration unit
       [Arguments]   ${DUR_VALUE}
       Select From List By Label      ${XPATH_TO_DIS_DIS_BillCycles}         BillCycles
       input text                     ${XPATH_TO_DIS_DUR_VALUE}              ${DUR_VALUE}

#IF the slab has minimum
Slab mini fuction for If
       [Arguments]    ${MIN_SLAB}
       input text                   ${XPATH_TO_DIS_MIN_SLAB}       ${MIN_SLAB}

#IF its selected
Run the selected bills
       click element             ${XPATH_TO_DIS_SELECT_INVOICE}
       click element             ${XPATH_TO_DIS_SELECT_ALL}

View and Launch the cycle
       [Arguments]        ${NEW_DIS_VERIFY}
       Run Keyword If    '${NEW_DIS_VERIFY}'=='Success'   View and Launch the cycle for IF



#ALL the arguments needed for the *** test cases ***
${ALL_DISCOUNT_ARGUMENTS}=     ${DIS_NAME}  ${DURATION}  ${DUR_VALUE}  ${DISC_GL_CODE}  ${DIS_ORIGIN}  ${TARGET}  ${APP_FOR}  ${COUNTED_TOWARDS}  ${SLAB_TYPE}  ${MIN_SLAB}  ${MAX_SLAB}   ${DIS_SLAB}  ${NEW_DIS_VERIFY}  ${EDIT_DIS_NAME}  ${EDIT_APP_FOR}  ${EDIT_DISC_GL_CODE}  ${EDIT_DIS_VERIFY}