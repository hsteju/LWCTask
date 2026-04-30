public class DataBAseClass {
    public static void dataBaseClass()
    {
        // create a List of Contacts
        List<Contact> contactList = new List<Contact>
        {
            new Contact(FirstName='sanjay',LastName='Rao',Cities__c ='Goa'),
            new Contact(FirstName='Vikas',LastName='Gupta',Cities__c ='Bangalore'),
            new Contact()
        };
            
        // Bulk insert all contacts with 1 DML Call
        Database.SaveResult[] srList = Database.insert(contactList,false);
        // iterate through each returned result
        for (Database.SaveResult sr : srList)
        {
            if(sr.isSuccess())
            {
                System.debug('Sucessfully inserted contact. Contact ID :'+sr.getId());
            }
            else{
                for(Database.Error err :sr.geterrors())
                {
                    System.debug('the following error has occured');
                    System.debug(err.getstatusCode()+':'+err.getMessage());
                    System.debug('Contact fields that affected this error:'+ err.getFields());
                }
            }
        }
    }

}