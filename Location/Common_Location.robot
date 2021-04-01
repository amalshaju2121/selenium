
*** Variables ***
#User Details
${USER_ID}            collections
${PASSWORD}           Tecnotree@123


#URL ID TO BILL UI
#${URL}            https://mtng.cluster1.devtestlab2.tecnotree.com/ngb-ui/#/billing-operations/billrun-monitoring/
${URL}          http://dcbs.cluster1.devtestlab2.tecnotree.com/ngb-ui/#/system-configurations/billing-configurations/billing-cycles/
${BROWSER}            gc           #CHROME AS BROWSER

#ID & XPATH TO LOG IN  THE BILLUI SITE
${XPATH_TO_USERNAME_TEXTBOX}       username
${XPATH_TO_PASSWORD_TEXTBOX}       password
${LOGIN_SUBMIT BUTTON}             //input[@class="btn btn-primary"]

# XPATH TO REACH TILL NEW BUTTON
${CONFIGURATION}                   //a[@class="ng-scope"]
${BILLING_CYCLE}                   //a[@translate="Billing Cycles"]


#BUTTON TO SAVE THE BILL
${SAVE}           //*[text()='Save']
${CANCEL}         //*[text()='Cancel']










