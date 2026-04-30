trigger Review on Account (before insert) {
    if (Trigger.isBefore && Trigger.isInsert) {
        Set<String> contact = new Set<String>();
        
        List<Contact> contacts = [SELECT Phone FROM Contact WHERE Phone != NULL];
        for (Contact con : contacts) {
            contact.add(con.Phone);
        }
        
        for (Account acc : Trigger.new) {
            if (acc.Phone != NULL && contact.contains(acc.Phone)) {
                acc.addError('The Phone number is already present in contact');
            }
        }
    }
}