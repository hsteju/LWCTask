trigger Account on Account (before insert, after insert, after update, before delete) {
  /*  
    // 1. Populate Description if null
    if(Trigger.isBefore && Trigger.isInsert) {
        for(Account acc : Trigger.new) {
            if(acc.Description == null) {
                acc.Description = 'Hi autopopulate';
            }
        }
    }
    
    // 2. Validate Phone
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        for(Account acc : Trigger.new) {
            if(acc.Phone != null && acc.Phone != '1234') {
                acc.addError('Incorrect Password');
            }
        }
    }

    // 3. Update related Contacts if Industry changes
    if(Trigger.isUpdate) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for(Account acc : Trigger.new){
            Account oldAcc = Trigger.oldMap.get(acc.Id);
            if(acc.Industry != oldAcc.Industry) {
                for(Contact c : [SELECT Id FROM Contact WHERE AccountId = :acc.Id]){
                    c.Description = 'Account industry changed to ' + acc.Industry;
                    contactsToUpdate.add(c);
                }
            }
        }
        if(!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }

    // 4. Prevent delete if Account has Opportunities
    if(Trigger.isDelete) {
        for(Account acc : Trigger.old) {
            if([SELECT count() FROM Opportunity WHERE AccountId = :acc.Id] > 0) {
                acc.addError('You cannot delete Account because it has Opportunities.');
            }
        }
    }
*/
}