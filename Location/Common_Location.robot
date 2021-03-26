
*** Variables ***
#User Details
${USER_ID}            collections
${PASSWORD}           Tecnotree@123



#URL ID TO BILL UI
${URL}                https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdcbs.cluster1.devtestlab2.tecnotree.com%2Fngb-ui%2F&data=04%7C01%7CAmal.Shaju%40tecnotree.com%7C16d57dacc5dc497e7db408d8c7482859%7C176a79e7ee0947d9b51fcadf37972564%7C0%7C0%7C637478460463072885%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=bxudawN6VRWjT4w%2F%2F9Obp%2FL67Ceorn6X6iDPfsdVApo%3D&reserved=0
${BROWSER}            gc           #CHROME AS BROWSER

#ID & XPATH TO LOG IN  THE BILLUI SITE
${XPATH_TO_USERNAME_TEXTBOX}       username
${XPATH_TO_PASSWORD_TEXTBOX}       password
${LOGIN_SUBMIT BUTTON}             //input[@class="btn btn-primary"]

# XPATH TO REACH TILL NEW BILL BUTTON
${CONFIGURATION}                   //a[@class="ng-scope"]
${BILLING_CYCLE}                   //a[@translate="Billing Cycles"]
${NEW_BILL_CYCLE}                  //button[@class="btn btn-primary btn-xs"]



#BUTTON TO SAVE THE BILL
${SAVE}           //*[text()='Save']
${CANCEL}         //*[text()='Cancel']

#BUTTON TO EDIT THE BILL
${EDIT_BUTTON}             //a[@is-allowed="ngb.fe.billingConfigurations.billCycle.edit"]











