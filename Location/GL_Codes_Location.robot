*** Variables ***
#start to gl code
${XPATH_TO_GL_CODES_BUTTON}         //a[@ng-click="redirectTo('billing-configurations.gl-codes')"][1]
${NEW_GL_CODES}                     //*[text()='New GL Code']

#edit and audit button
${XPATH_TO_EDIT_BUTTON}             xpath=//td[3]/a
${XPATH_TO AUDIT}                   xpath=//td[3]/a[2]
${XPATH_TO_DROPDOWN_BUTTON}             //*[text()='DCBS'][1]

#input Xpaths
${XPATH_TO_NAME_TEXTBOX}           //input[@ng-model="dialogParams.name"]
${XPATH_TO_CODE_TEXTBOX}           //input[@class="form-control ng-pristine ng-untouched ng-invalid ng-invalid-required ng-valid-pattern ng-valid-maxlength"]

#edit input xpath
${XPATH_TO_NEW_NAME_TEXTBOX}        xpath=//input[@name='glName']

