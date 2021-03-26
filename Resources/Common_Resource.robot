*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Bill_Cycle_Location.robot
Library    DataDriver     ../Test_Data/bill.xlsx   sheet_name=Sheet1   #excel file

*** Keywords ***
#suit setup files & Teardown files
Login To website
         open browser                    ${URL}     ${browser}
         set selenium implicit wait      10s
         maximize browser window
         input text                      ${XPATH_TO_USERNAME_TEXTBOX}          ${USER_ID}
         input text                      ${XPATH_TO_PASSWORD_TEXTBOX}          ${PASSWORD}
         click element                   ${LOGIN_SUBMIT BUTTON}

Close Browsers
         close all browsers

#Setup till config
Setup
         Reload Page
         set selenium implicit wait         10s
         click element               ${CONFIGURATION}
