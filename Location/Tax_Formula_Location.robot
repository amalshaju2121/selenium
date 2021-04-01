*** Variables ***
#main xpath till  new cycle
${XPATH_TO_TAX_FORMULA}               //a[@translate="Tax Formula"]
${NEW_BILL_TAX_FORMULA}               //*[text()='New Tax Formula']



#XPATH TO TEXTBOX TO DROP DATA
${XPATH_TO_CODE_TAX_FORMULA}          //input[@ng-model="dialogParams.formulaCode"]
${XPATH_TO_NAME_TAX_FORMULA}          //input[@placeholder="type Formula name here"]
${XPATH_TO_TAX_PLAN_FORMULA}          //input[@placeholder="type Tax Plan formula here"]
${XPATH_TO_GL_CODE_PLAN_FORMULA}      //select[@ng-options="glCode.code as glCode.name for glCode in glCodes"]

#EDIT SECTION XPATHS

${XPATH_TO_EDIT_NAME_TAX_FORMULA}      //input[@ng-model="dialogParams.uuid.name"]
${XPATH_TO_EDIT_TAX_FORMULA}          //input[@placeholder="type Tax Plan formula here"]


#Audit section
${XPATH_TO_AUDIT_TAX}                  xpath=//td[3]/a
${XPATH_TO_DROPDOWN_TAX}               //*[text()='DCBS'][1]
#The pop up text to verify
${Pass}        Your Request is Successfully Processed
${Failed}      formula
${Fail}        Error


#edit section
${XPATH_FOR_EDIT}                    //a[@ng-class="{'rotate-right':item._meta.expanded}"]
${XPATH_TAX_EDIT_BUTTON}             //*[text()='Edit']
