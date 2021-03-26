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
         click element          //a[@ng-click="redirectTo('billing-configurations.gl-codes')"]
New GL Code cycle
         GL_Codes_Setup
         set selenium implicit wait      10s
         click element          //*[text()='New GL Code']


#Fuction for generating random strings
Initialize Random Variables for GL Code cycle
         ${RANDOM_CYCLE_NAME}=   Generate random string        15
         Set global variable     ${RANDOM_CYCLE_NAME}
         ${RANDOM_GL_CODE}=   Generate random string        4       [NUMBERS]
         Set global variable     ${RANDOM_GL_CODE}
         ${RANDOM_EDIT_NAME}=   Generate random string         15
         Set global variable     ${RANDOM_EDIT_NAME}

#Fuctions to give to main test keyword
Give input to GL Code cycle
         [Arguments]   ${GL_CODE_NAME}     ${GL_CODE}
         input text         //input[@ng-model="dialogParams.name"]          ${GL_CODE_NAME}
         input text        //input[@class="form-control ng-pristine ng-untouched ng-invalid ng-invalid-required ng-valid-pattern ng-valid-maxlength"]                    ${GL_CODE}
         click element                    ${SAVE}
${ALL_ARGUMENTS}=     ${GL_CODE_NAME}     ${GL_CODE}      ${GL_CODE_NEW_NAME}     ${EXPECTED_TEXT_TO_VERIFY_NEW_GL_CODE}    ${EXPECTED_TEXT_TO_VERIFY}