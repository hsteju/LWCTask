public class SobjectsLoop {
    public static void sObjectsDemo()
    {
        List<Account> accList = new List<Account>();
        Set<Id> accIds = new Set<Id>();
        Map<Id,Account> accMap =new Map<Id,Account>([SELECT Id,Name FROM Account Limit 2]);
        //Map<Id,Account> map =new Map<Id,Account>(accList);
        
        accList = [SELECT Id,Name FROM Account Limit 2];
        System.debug('accList =>'+accList);
        
        // List
        for (Account acc : accList)
        {
            System.debug('accList =>'+accList);
        }
       
        if(!accList.isEmpty())
        {
           for (Account acc : accList)
       	   {
               accIds.add(acc.Id);
            } 
        }  
        System.debug('accIds =>'+accIds);
        
       for (Account acc : [SELECT Id,Name FROM Account Limit 2])
   	   {
          accIds.add(acc.Id);
       }  
        System.debug('accIds using soql no if is required =>'+accIds);
        
        // For set
        if(!accIds.isEmpty())
        {
            for(Id i : accIds)
            {
                System.debug('accids set =>'+i);
            }
        }
        
        // Map
        if(!accIds.isEmpty())
        {
            for(Id i : accIds)
            {
                if(accMap.containsKey(i))
                {
                    System.debug('Map values =>'+accMap.get(i));
                }
                System.debug('accids set =>'+i);
            }
        }
        
    }

}