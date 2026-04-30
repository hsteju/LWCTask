public class ListDemo {
    public static void listMethod()
    {
        Boolean res;
        List<String> strList = new List<String>();
        List<String> strList2 = new List<String>();
        Set<String> strSet = new Set<String>();
        List<String> strList3 = new List<String>();
        
        // Type
        sObject sobj = [SELECT Id,Name from Account Limit 1];
        System.debug('sObj type => '+sobj.getSObjectType());
         sObject sobj1 = [SELECT Id,Name from Contact Limit 1];
        System.debug('sObj type => '+sobj1.getSObjectType());
        
        strList.add('USA');
        strList.add('USA');
        strList.add('India');
        System.debug('Countries : '+strList);
        System.debug('Getmethod use index =>'+strList.get(1));
        System.debug('Index =>'+strList.indexOf('India'));
        System.debug('List IsEmpty =>'+strList.isEmpty());
        
        strList.add(1,'Japan');
        System.debug('Countries : '+strList);
        
        strList2.add('UK');
        strList2.addAll(strList);
        System.debug('Adding 2 List :'+ strList2);
        
        strSet.add('China');
        strList2.addAll(strSet);
        System.debug('Adding set to list :'+ strList2);
        
        strList3 = strList.clone();
        System.debug('strList3 : '+strList3);

        res= strList.contains('India');
        System.debug('Contains = '+res);
        
        res= strList.equals('strList3');
        System.debug('Equals = '+res);
        
    }

}