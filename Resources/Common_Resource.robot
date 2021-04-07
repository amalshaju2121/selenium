*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Bill_Cycle_Location.robot

*** Keywords ***
#suit setup files & Teardown files
Login To website
         open browser                    ${URL}     ${browser}
         set selenium implicit wait      20s
#         click element               //button[@id="details-button"]
#         click element      //*[text()='Proceed to mtng.cluster1.devtestlab2.tecnotree.com (unsafe)']
         maximize browser window
         Wait Until Element Is Visible   ${XPATH_TO_USERNAME_TEXTBOX}
         input text                      ${XPATH_TO_USERNAME_TEXTBOX}          ${USER_ID}
         input text                      ${XPATH_TO_PASSWORD_TEXTBOX}          ${PASSWORD}
         click element                   ${LOGIN_SUBMIT BUTTON}

Close Browsers
         close all browsers

#Setup till config
Setup
         Reload Page
         set selenium implicit wait       20s
         Wait Until Element Is Visible    ${CONFIGURATION}
         click element                    ${CONFIGURATION}
