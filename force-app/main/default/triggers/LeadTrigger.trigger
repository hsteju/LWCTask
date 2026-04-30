trigger LeadTrigger on Lead (before update) {
    // Whenever a Lead Record is updated, set the Lead Status to Working-Contacted if the city is metro
    // when a lead is updated we need to set the Source as Purchased List, SIC code as 1100, Primary as yes

    if (Trigger.isBefore && Trigger.isUpdate) {
        LeadTriggerHandle.handleActivitiesAfterUpdate(Trigger.new);
    }
}
  
    /*
    if (Trigger.isBefore && Trigger.isUpdate) {
        for (Lead le : Trigger.new) {
            if (le.Cities__c == 'Metro') { // Check if the city is metro
                System.debug('Lead Update');
                le.Status = 'Working - Contacted'; // Update status if city is metro
            }
            else if(le.Industry == 'Healthcare')
            {
                le.LeadSource = 'Purchased List';
                le.SICCode__c ='1100';
                le.Primary__c ='Yes';
            }
        }
    }
*/