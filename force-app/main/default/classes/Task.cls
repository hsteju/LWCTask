public class Task {
    public static void accountWithContacts()
    {
        List<Account> accountsWithContacts = [SELECT Id ,Name, (SELECT Name FROM Contacts)
                                             From Account 
                                             Limit 5];
        for(Account acc : accountsWithContacts)
        {
            System.debug('Account With Contact :' + acc.Name);
        }
    }
    
   public static void accountWithoutContacts() {
    // Query accounts without contacts
    List<Account> accountsWithoutContacts = [SELECT Id, Name, Cities__c 
                                             FROM Account 
                                             WHERE Id NOT IN (SELECT AccountId FROM Contact)];
    
    // Debug accounts without contacts
    for (Account acc : accountsWithoutContacts) {
        System.debug('Account without contact: ' + acc.Name + ', City: ' + acc.Cities__c);
    }
    
    // Retrieve the specific contact
    Contact addContact = [SELECT Id, FirstName, LastName 
                          FROM Contact 
                          WHERE Id = '003Qy00000ILaKfIAL' LIMIT 1];
    
    // Debug the specific contact
    System.debug('Contact: ' + addContact.FirstName + ' ' + addContact.LastName);
    
    // Create a list to hold new contacts
    List<Contact> newContacts = new List<Contact>();
    
    // Iterate through accounts and create a new contact for each
    for (Account acc : accountsWithoutContacts) {
        Contact newContact = new Contact(
            FirstName = addContact.FirstName,
            LastName = addContact.LastName,
            AccountId = acc.Id,
            Cities__c = acc.Cities__c // Ensure the required field is populated
        );
        newContacts.add(newContact);
    }
    
   }

    
}