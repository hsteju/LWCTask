public class Insertion {
    public static void insertMethod()
    {
        Account acc = new Account();
        acc.name = 'Salesforce gyaan';
        INSERT acc;
        System.debug('Record Inserted : '+ acc);
      
    }
}