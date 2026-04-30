public class SetDemo {
    public static void setMethod()
    {
        Set<String> strSet = new Set<String>();
        strSet.add('India');
        strSet.add('India');
        System.debug('Set =>'+strSet);
    }
    
    public static void mapMethod()
    {
        Map<Integer,String> strMap = new Map<Integer,String>();
        strMap.put(1,'India');
        strMap.put(2,'USA');
        System.debug('Map =>'+strMap);
        
        strMap.put(2,'UK');
        System.debug('Map =>'+strMap);
        
        System.debug('Map =>'+strMap.values()); // to get only values
         System.debug('Map =>'+strMap.keySet()); // to get only Keys
    }

}