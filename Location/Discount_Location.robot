*** Variables ***
#basic xpath top reach the cycle page
${XPATH_TO_DISCOUNTS}              //a[@ng-click="redirectTo('billing-configurations.discounts')"]
${XPATH_TO_NEW_CYCLE_DISCoUNT}     //button[@is-allowed="ngb.fe.billingConfigurations.discounts.add"]


#xpath to input data to the new cycle
${XPATH_TO_DISC_NAME}              //input[@placeholder="Discount Name"]
${XPATH_TO_DURATION}               xpath=//select[@name='duration']
${XPATH_TO_DIS_GL_CODE}            xpath=//select[@name='glCode']
${XPATH_TO_DIS_ORIGIN}             //SELECT[@ng-model="discountData.origin"]
${XPATH_TO_DIS_TARGET}             //SELECT[@name="target"]
${XPATH_TO_DIS_APP_FOR}            //input[@ng-model="discountData.applicableFor"]
${XPATH_TO_DIS_SLAB_TYPE}          //select[@ng-change="setSlab(discountData.slabValueType)"]
${XPATH_TO_DIS_MIN_SLAB}           //input[@ng-model="slab.min"]
${XPATH_TO_DIS_MAX_SLAB}           //input[@ng-model="slab.max"]
${XPATH_TO_DIS_DIS_SLAB}           //input[@name="discountslab0"]
${XPATH_TO_DIS_DIS_BillCycles}     //select[@ng-click="changeLifeCycleValue(discountData.lifeCycle.durationUnit)"]
${XPATH_TO_DIS_DUR_VALUE}          //input[@ng-model="discountData.lifeCycle.value"]

#for new bill
${SUBMIT_BUTTON}                   //button[@ng-click="submitData(discountData,discountForm.$valid)"]

#Xpath to the select
${XPATH_TO_DIS_SELECT_INVOICE}     xpath=(//input[@name='selectedInvoices'])[2]
${XPATH_TO_DIS_SELECT_ALL}         //button[@class="btn btn-default ng-binding ng-scope"][1]
${XPATH_TO_DIS_RANDOM_SELECT}      xpath=(//input[@name='category[]'])[2]

#For audit section
${XPATH_TO_DIS_AUDIT_CLICK}        xpath=//td[10]/a
${XPATH_TO_DIS_AUDIT_DROPDOWN}     //*[text()='DCBS'][1]
${XPATH_TO_DIS_EDIT_CLICK}         xpath=//td[9]/a


#or view section
${XPATH_TO_DIS_VIEW_CLICK}         xpath=//td[8]/button
${XPATH_TO_DIS_LAUNCH_CLICK}       xpath=//td[7]/button

#for LAUNCHED verification
${LAUNCHED}                        LAUNCHED


#Slab section
${XPATH_TO_DIS_ADD_SLAB_CLICK}     //button[@ng-click="addSlab()"]
${XPATH_TO_DIS_MAX_SLAB-2}         xpath=//input[@name='maxslab1']
${XPATH_TO_DIS_DIS_SLAB-2}         xpath=//input[@name='discountslab1']
${XPATH_TO_DIS_MAX_SLAB-3}         xpath=//input[@name='maxslab2']
${XPATH_TO_DIS_DIS_SLAB-3}         xpath=//input[@name='discountslab2']