global class Scheduleclass implements Schedulable {
    
    // This method runs when the job is scheduled
    global void execute(SchedulableContext sc) {
        // Example: Update all Accounts with a description
        List<Account> accountsToUpdate = [SELECT Id, Description FROM Account LIMIT 10];
        for (Account acc : accountsToUpdate) {
            acc.Description = 'Updated by Scheduled Job at ' + System.now();
        }
        update accountsToUpdate;

        System.debug('Scheduled Job executed at: ' + System.now());
    }
}