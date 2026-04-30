public class DataTypesDemo {
	public DataTypesDemo()
    {
        System.debug('I am in Constructor');  // Constructor
    }
    
    public void methodDemo()
    {
        System.debug('I am calling methods'); // Methods
    }
    
    Boolean b ;   // primitive
    public void dataTypes()
    {
        b= true;
        System.debug('I am in dataTypes'); 
        System.debug('b = '+b);
    }
    
    // Specific sObjects 
     public void sObject()
    {
        Account acc = new Account();
        acc.Name = 'Test1';
        acc.Cities__c = 'Goa';
        System.debug('Account = '+acc);
    }
    
     // Generic sObjects 
     public void genericSObject()
    {
        sObject sobj1 = new Account(Name='Test2',Cities__c='Goa');
        // Typecasting == converting Generic to a specific sObject
        Account acc = (Account)sobj1;      
        System.debug('Account = '+acc);
    }
    
    // List
     public void listDemo()
    {
        // List<String> strList = new List<String>();
        List<String> strList = new List<String>{'1','2'};
        System.debug('List Contains = '+strList);
        strList.Clear();
        strList.add('20');
        strList.add('A');
        System.debug('List Contains = '+strList);
    }
    
    // List Query
     public void listQuery()
     {
         List<Account> accList = [SELECT Id, Name From Account Limit 1];
         System.debug('Account List = '+accList);
     }
    
    // Map
    public void mapDemo()
    {
        Map<String,String> mapDemo = new map<String,String>();
        mapDemo.put('1','First');
        mapDemo.put('2','Second');
        mapDemo.put('3','Third');
        System.debug('Map Values = '+ mapDemo);
    }
    
    // Map Query
    public void mapQuery()
    {
        List<Account> accList = [SELECT Id, Name From Account Limit 2];
        Map<Id ,Account> mapQuery = new Map<ID ,Account>(accList);
        System.debug('mapQuery ='+mapQuery);
        
        // Check
        Map<Account,List<Contact>> accCon = new Map <Account,List<Contact>>();
        System.debug('Acccount and Contact = '+accCon);
    }  
    
}