global class UpdateTrainingStatusBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Status__c, Training_Stage__c, Start_Date__c, End_Date__c 
            FROM Opportunity 
            WHERE Status__c = 'Confirmed' AND ID='006Qy00000JOY7FIAX'
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        Date today = Date.today();
        List<Opportunity> updateList = new List<Opportunity>();

        for (Opportunity opp : scope) {
            System.debug('>>> Opp: ' + opp.Id +
                         ', Status: ' + opp.Status__c +
                         ', Stage: ' + opp.Training_Stage__c +
                         ', Start: ' + opp.Start_Date__c +
                         ', End: ' + opp.End_Date__c +
                         ', Today: ' + today);

            if (opp.Training_Stage__c == 'Confirmed' &&
                opp.Start_Date__c != null && opp.End_Date__c != null &&
                today >= opp.Start_Date__c && today <= opp.End_Date__c) {
                opp.Training_Stage__c = 'In Progress';
                updateList.add(opp);
                System.debug('Updated to In Progress: ' + opp.Id);
            }
            else if (opp.Training_Stage__c == 'In Progress' &&
                     opp.End_Date__c != null && today > opp.End_Date__c) {
                opp.Training_Stage__c = 'Completed';
                updateList.add(opp);
                System.debug('Updated to Completed: ' + opp.Id);
            }
        }

        Update updateList;
  System.debug('Updated Opportunities: ' + updateList);
      
    }

    global void finish(Database.BatchableContext bc) {}
}