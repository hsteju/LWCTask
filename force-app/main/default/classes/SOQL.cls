public class SOQL {
    public static void mySOQL()
    {
        List<Account> acc = [SELECT Name,Id From Account];
        // To Iterate over the SObject
        for (integer i=0 ; i<acc.size();i++)
        {
            System.debug('acc[i]: '+acc[i].Name);
        }
        
        // Using for each Loop
        for(Account a :acc)
        {
            System.debug('Acc Name :'+a.Name);
        }
    }
    
    // want Dynamic SOQL
    // Where user gives input i want output based on that
    // So We use SOQL VARIABLE BINDING
    // We need to pass the values into the method then :s ->in order to get the Value
    
    public static void dynamicSoql(string s)
    {
        // Static Value
       // List<Contact> con =[SELECT firstName,LastName, Email from Contact where LastName='marks'];
        
        // Dynamic Value
        List<Contact> con2 =[SELECT firstName,LastName, Email from Contact where LastName= :s];
		System.debug(con2);
    }
    
    // SOQL Keywords
    // IN
    public static void soqlkeyword()
    {
        //with List
        List<String> nameList = new List<String>{'test','marks'};
        List<Contact> conList1 = [SELECT Id,Name from Contact where Name In :nameList];
        System.debug(conList1);
        
        // with Set
        Set<String> nameSet = new Set<String>{'test','marks'};
        // SOQL always returns List
        List<Contact> conList2 = [
            SELECT Id, Name
            FROM Contact
            WHERE Name IN :nameSet
        ];
        
        // Convert List to Set if needed
        Set<Contact> conSet1 = new Set<Contact>(conList2);
        System.debug(conSet1);
    }

    
}