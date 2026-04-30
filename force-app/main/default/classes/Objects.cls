public class Objects {
    public static void demoMethod()
    {
        // Standard
        Account acc = new Account(Name ='Test',Cities__c='Goa');
        Account acc1 = new Account();
        acc1.Name ='Test1';
        acc1.Cities__c='Goa';
        System.debug('Standard =>'+acc);
        System.debug('Standard =>'+acc1);
        
        // Custom
        Transporter__c trp = new Transporter__c();
        trp.Name='TrpName';
        System.debug('Custom=>'+trp);
        
        //Generic == can be used in both standard and custom
        sObject obj; 
        obj = new Account(Name ='Test3',Cities__c='Goa');
        Account acc3 =(Account)obj;
        System.debug('Generic =>'+acc3);
    }
}