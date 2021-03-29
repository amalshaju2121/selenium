*** Settings ***
Documentation      Suite Description
Library            Selenium2Library
Resource           ../Location/Common_Location.robot
Resource           ../Location/Charges_Location.robot
Resource           ./Common_Resource.robot
Library    DataDriver     ../Test_Data/Data.xlsx   sheet_name=Sheet3   #excel file

*** Keywords ***

Login To Charges Website
         Login To website
         Initialize Random Variables for Charges cycle   #Bringing the random name fuction to suit setup
Charges_Setup
         Setup
         click element                         //a[@ng-click="redirectTo('billing-configurations.charges')"]
New Charges cycle
         Charges_Setup
         click element                         //*[text()='New Charge']




#Fuction for generating random strings
Initialize Random Variables for Charges cycle
         ${RANDOM_NAME}=    Generate random string        15
         Set global variable      ${RANDOM_NAME}
         ${RANDOM_GL_CODE}=       Generate random string        4       [NUMBERS]
         Set global variable      ${RANDOM_GL_CODE}
         ${RANDOM_EDIT_NAME}=     Generate random string        13
         Set global variable      ${RANDOM_EDIT_NAME}


#Fuctions to give to main test keyword
Give input to Charges cycle
         [Arguments]             ${NAME}     ${TYPE}       ${GL_CODE}      ${TAX_PLAN}    ${NEW_VERIFY}
         input text            //input[@placeholder="type Charge name here"]          ${NAME}
         Select From List By Label       //select[@ng-change="resetcharge(dialogParams.chargeClass)"]              ${TYPE}
         Select From List By Label        //select[@data-role="charge-config-gl-code"]          ${GL_CODE}
         Run Keyword If   '${TYPE}'!='Deposit'       Tax plan XPATH     ${TAX_PLAN}
         click element           ${SAVE}
         #Waiting for confirmation
         wait until page contains           ${${NEW_VERIFY}}
Verification
         [Arguments]    ${NAME}     ${TYPE}       ${GL_CODE}
         Charges_Setup
         wait until page contains         ${NAME}
         wait until page contains         ${TYPE}
         wait until page contains         ${GL_CODE}


Tax plan XPATH
         [Arguments]           ${TAX_PLAN}
         Select From List By Label     //select[@ng-options="taxPlan.id as taxPlan.name for taxPlan in dialogParams.taxPlans"]      ${TAX_PLAN}
