*** Variables ***
#main selection
${NEW_BILL_CYCLE}                      //button[@class="btn btn-primary btn-xs"]


#XPATH TO TEXTBOX TO DROP DATA
${XPATH_TO_CYCLE_NAME_TEXTBOX}          //input[@name="configname"]
${XPATH_TO_PERIODICITY_TEXTBOX}         //select[@ng-change='resetbimonthly()']
${XPATH_TO_START_DATE_TEXTBOX}          //select[@name='starts']
${XPATH_TO_START_MONTH_TEXTBOX}         //select[@name='startsFrom']
${XPATH_TO_CUSTOMER_TYPE_TEXTBOX}       //select[@name='customerType']



#verification Xpath
${XPATH_TO_VERIFY_NAME}                 //td[@data-role="name"]
${XPATH_TO_VERIFY_PERIODICITY}          //td[@data-mobile-label="Periodicity"][1]
${XPATH_TO_VERIFY_START_DATE}           //td[@data-mobile-label="StartsDay"][1]
${XPATH_TO_VERIFY_CUSTOMER_TYPE}        //td[@data-mobile-label="Customer Type"][1]


#xpath to Audit section to verify and check the test
${XPATH_TO_DROPDOWN_BUTTON}             //*[text()='DCBS'][1]
${XPATH_TO_AUDIT_BUTTON}                //a[@ng-click="showAuditLog(item); $event.stopPropagation()"][1]



#BUTTON TO EDIT
${EDIT_BUTTON}             //a[@is-allowed="ngb.fe.billingConfigurations.billCycle.edit"]




