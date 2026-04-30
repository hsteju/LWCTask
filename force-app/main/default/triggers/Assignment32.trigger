trigger Assignment32 on Account (after insert, after update) {
    List<Contact> contactsToCreate = new List<Contact>();
    
    for (Account acc : Trigger.new) {
        Integer numContacts = acc.Contacts_to_be_Created__c != null ? Integer.valueOf(acc.Contacts_to_be_Created__c.intValue()) : 0;
        if (numContacts > 0) {
            for (Integer i = 1; i <= numContacts; i++) {
                Contact newContact = new Contact(
                    LastName = 'Contact' + i,
                    AccountId = acc.Id
                );
                contactsToCreate.add(newContact);
            }
        }
    }
    
    if (!contactsToCreate.isEmpty()) {
        insert contactsToCreate;
    }
}