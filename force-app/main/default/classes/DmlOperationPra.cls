public class DmlOperationPra {
    public static void dmlOperations()
    {
        // Insert
        Account acc = new Account(Name='Tech School',Cities__c='Bangalore',Phone='1234455');
        insert acc;
        
        System.debug('accId = '+acc.id);

        // Bulk Insert
        Account acc1 = new Account(Name='Tech School2',Cities__c='Bangalore',Phone='1234455');
        Account acc2 = new Account(Name='Tech School3',Cities__c='Bangalore',Phone='1234455');
        List<Account> accList = new List<Account>();
        accList.add(acc1);
        accList.add(acc2);
        insert accList;
        System.debug('accList = '+accList);
        
        // Create an Account and insert an Contact to that OR Releated records using id
        Account acc4 = new Account(Name='Zen',Cities__c='Goa',Phone='1234455');
        insert acc4;
        
        Contact con = new Contact(FirstName='Karishma',LastName='k',Cities__c='Bangalore',AccountId=acc4.Id);
        insert con;
        System.debug(acc4);
        System.debug(con);
  
        // Updateing the Phone Number in the Account
        Account acc5 = [SELECT Id,Name,phone from Account Where Name ='Zen'];
        System.debug('query acc=> '+acc5);
        
        acc5.phone = '123445566667777';
        update acc5;
        
        Account Updatedacc5 = [SELECT Id,Name,phone from Account Where Name ='Zen'];
        System.debug('Updated query acc=> '+Updatedacc5);
        // Check the below code 
        System.assertEquals(Updatedacc5.Phone ,acc5.Phone,'equal');

        // Update the contact phone no and there releated account phone no also
        Contact con1 = [Select Id,FirstName,LastName ,Account.Phone,AccountId
                       From Contact 
                       Where FirstName='Karishma' AND  LastName='k' 
                       And AccountId != null];
        System.debug(con1);
        con1.Phone ='123456';
        update con1;
        con1.Account.Phone = '11111';
        update con1.Account;
          
       // upsert We r inserting acc6 and updateing acc7
       List<Account> accList2 = new List<Account>();
       Account acc6 = new Account(Name='Tech School1', Phone='1234455',Cities__c = 'Goa');
       Account acc7 = [SELECT Id,Name,Phone 
                      From Account
                      Where Name ='Tech School'];
        acc7.Phone='123';
    	accList2.add(acc6);
        accList2.add(acc7);        
		System.debug('Account List: ' + accList2);
        upsert accList2;
        
       // Inserting and updateing the same instace 
       List<Account> accList1 = new List<Account>();
       Account acc8 = new Account(Name='Tech School1', Phone='1234455',Cities__c = 'Goa');
       accList1.add(acc8);
       acc8.Phone='123';        
	   System.debug('Account List1 : ' + accList1);
       upsert accList1;
    
        // Merge 2 records and only the merged record will be present and the other will be deleted
        Account masterAcc =[ SELECT Id,Name,Phone From Account
                           WHERE Name ='Tech School1' Limit 1];
        Account mergeAcc =[ SELECT Id,Name,Phone From Account
                           WHERE Name ='Tech School' Limit 1];
        merge masterAcc mergeAcc;


        // Delete    
        List<Account> acc9 = [SELECT Id,Name,Phone 
                      FROM Account
                      WHERE Name ='Tech School2' Limit 1];
        undelete acc9;
      
        
        // UnDelete the Record
        List<Account> acc10 = [SELECT Id,Name,Phone 
                      FROM Account
                      WHERE Name ='Tech School1' ALL ROWS];
        undelete acc10;

        // DML with try and catch
        
        try{
            Account acc11 = new Account();
            insert acc;
        }
        catch(DMLException e)
        {
            System.debug('Error =>'+e.getMessage());
        }
        
    }

}