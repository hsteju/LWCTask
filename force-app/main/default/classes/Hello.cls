public class Hello {
   public static void AccountInsert() {
        Account acc = new Account();
        acc.Name = 'RCB';
        acc.Cities__c = 'Metro'; // Set a value for the required field
        
        insert acc;
        
        System.debug('acc: ' + acc);
   }
}