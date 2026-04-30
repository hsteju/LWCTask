public class PractiseClass {
    /* public void InsertData()
    {
        Account acc = new Account();
        acc.Name = 'Pra Test 1';
        acc.Cities__c = 'Bangalore';
        System.debug('Account : '+ acc);
    }

    public void DMLOperaton()
    {
        Opportunity opp = new Opportunity(Name='DSL',Cities__c='Bangalore');
        insert opp;
    }
*/
    public static void calculate(){
       List<Integer> num = new List<Integer>();
        
        for (Integer i=0 ;i<=20 ; i++)
        {
            num.add(i);
        }
        
        System.debug('Initial'+ num);
        
        Integer sum =0;
        
        for( Integer i= 0 ;i <num.size(); i+=2)
        {
            sum+= num[i];
        }
        
        System.debug('Initial'+ sum);
    }
}