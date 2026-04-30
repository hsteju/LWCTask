public class assignment22 implements Database.Batchable<sObject>, Database.Stateful {
    public Integer recordCount = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('Start method: Querying Accounts with BillingCountry populated');
        return Database.getQueryLocator([
            SELECT Id, Name, BillingCountry, (SELECT Id, Status__c FROM Contacts) 
            FROM Account 
            WHERE BillingCountry != NULL
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        System.debug('Execute method: Processing ' + scope.size() + ' Account records');
        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : scope) {
            System.debug('Processing Account: ' + acc.Name + ' (ID: ' + acc.Id + ')');
            if (acc.Contacts.size() > 0) {
                Boolean allClosed = true;
                for (Contact con : acc.Contacts) {
                    System.debug('Checking Contact: ' + con.Id + ' with Status__c: ' + con.Status__c);
                    if (con.Status__c != 'Closed') {
                        allClosed = false;
                        System.debug('Contact ' + con.Id + ' is not Closed. Skipping Account update.');
                        break;
                    }
                }
                if (allClosed) {
                    acc.Status__c = 'Closed';
                    accountsToUpdate.add(acc);
                    System.debug('All related Contacts are Closed. Marking Account ' + acc.Name + ' as Closed.');
                }
            } else {
                System.debug('No Contacts found for Account ' + acc.Name + '. Skipping Account.');
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
            recordCount += accountsToUpdate.size();
            System.debug('Updated ' + accountsToUpdate.size() + ' Accounts to Closed status.');
        } else {
            System.debug('No Accounts were updated.');
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Finish method: Batch process completed. Total records processed: ' + recordCount);
    }
}