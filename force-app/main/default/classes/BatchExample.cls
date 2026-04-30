public class BatchExample implements Database.Batchable<sObject>, Database.stateful {
    public integer recordCount = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Name, Cities__c FROM Opportunity]);
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> ops) {
        for (Opportunity op : ops) {
            op.LeadSource = 'Web';
            
            // Ensure Cities__c field is populated with 'Goa'
            if (op.Cities__c == null) {
                op.Cities__c = 'Goa'; // Assign 'Goa' as the value
            }
        }

        update ops;
        recordCount = recordCount + ops.size();
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Total records processed and count: ' + recordCount);
    }
}