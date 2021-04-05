*** Variables ***
#main xpath till  new cycle
${XPATH_TO_CHARGERS}                 //a[@ng-click="redirectTo('billing-configurations.charges')"]
${NEW_BILL_BUTTON_CHARGER}           //*[text()='New Charge']


#xpath to Audit section to verify and check the test
${XPATH_TO_AUDIT_BUTTON_CHARGER}            xpath=//td[7]/a[2]
${XPATH_TO_DROPDOWN_BUTTON_CHARGER}         //*[text()='DCBS'][1]


#BUTTON TO EDIT
${EDIT_BUTTON_CHARGER}                      xpath=//td[7]/a


#XPATH TO TEXTBOX TO DROP DATA
${XPATH_TO_CHARGE_NAME_TEXTBOX}             //input[@placeholder="type Charge name here"]
${XPATH_TO_TYPE_TEXTBOX}                    //select[@ng-change="resetcharge(dialogParams.chargeClass)"]
${XPATH_TO_GL_CODE_TEXTBOX_CHARGER}         //select[@data-role="charge-config-gl-code"]
${XPATH_TO_TAX_PLAN_TEXTBOX}                //select[@ng-options="taxPlan.id as taxPlan.name for taxPlan in dialogParams.taxPlans"]
${XPATH_TO_DISCOUNT_GL_CODE}                //select[@ng-model="dialogParams.discountApportionGlCode"]
${XPATH_TO_DIS_APP_CODE}                    //input[@ng-model="dialogParams.discountApportionChargeId"]


#EDIT XPATH
${XPATH_TO_EDIT_TAX_PLAN_TEXTBOX}                //select[@ng-model="dialogParams.uuid.taxPlanId"]
${XPATH_TO_EDIT_DISCOUNT_GL_CODE}               xpath=//select[@name='discountApportionGlCode']
${XPATH_TO_EDIT_DIS_APP_CODE}                   xpath=//input[@name='discountApportionChargeId']
#The pop up text to verify
${Pass}     Your Request is Successfully Processed
${Fail}     Error
