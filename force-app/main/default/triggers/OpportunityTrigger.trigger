trigger OpportunityTrigger on Opportunity (before insert, before update) {
    Date today = Date.today();

    for (Opportunity opp : Trigger.new) {
        if (opp.Status__c == 'Confirmed') {
            opp.Training_Stage__c = 'Confirmed';
        }
    }
}