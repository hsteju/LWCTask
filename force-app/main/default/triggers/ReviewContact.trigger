trigger ReviewContact on Contact (before insert) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        List<Contact> newContacts = Trigger.new;
        
        List<Contact> existingContacts = [SELECT Id, Cities__c FROM Contact];
        
        for (Contact newContact : newContacts) {
            for (Contact existingContact : existingContacts) {
                if (newContact.Cities__c != existingContact.Cities__c) {
                    newContact.addError('Same City');
                }
            }
        }
    }
}