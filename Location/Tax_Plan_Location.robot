*** Variables ***

#main xpath till  new cycle
${XPATH_TO_Tax_Plan_BUTTON}  //a[@ng-click="redirectTo('billing-configurations.tax-plan')"]
${NEW_Tax_Plan}                    //*[text()='New Tax Plans']

#XPATH TO TEXTBOX TO DROP DATA
${XPATH_TO_NAME_TAX_PLAN}      //input[@placeholder="type Tax Plan name here"]

#audit secion Xpaths
${AUDIT_BUTTON_TAX_PLAN}       xpath=//td[4]/a[2]
${AUDIT_DROP_TAX_PLAN}          //*[text()='DCBS'][1]

#edit button click
${EDIT_BUTTON_TAX_PLAN}         xpath=//td[4]/a

${VIEW_FORMULA}                 xpath=//button[contains(.,'View Formula')]
${ADD_FORMULA_BUTTTON}         xpath=//div[@id='dialogBody']/div/div[2]/button

#input text box for formula
${XPATH_TO_FORMULA_TEXTBOX}             //select[@data-role="charge-config-gl-code"]

#to verify the successfull adding
${Success}                      Success