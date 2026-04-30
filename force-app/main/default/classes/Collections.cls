public class Collections {
    public static void myListMethod()
    {
        // Createing & Initialization List --> In order to create a new list we use (new Keyword)
        // List <DataType> list = new List<Datatype>(); 
        
        //Initialize and the add values using add method
        List<Integer> l1 = new List<Integer>();
        l1.add(2);
        l1.add(4);
        l1.add(6);
        l1.add(4);
        System.debug(l1);
        
        //Initialize and adding values Together
        List<Integer> l2 = new List<Integer>{1,2,3,4};
        System.debug(l2);
            
        // String List
        List<String> s1 = new List<String>{'Hi Good','Morning'};
        System.debug(s1);
    }
    
    // List Array Notation -> List and Arrays are Exactly same
    // Even if we define size it dynamically change
    public static void myListArrayMethod()
    {
        // List Array Notation
        Integer[] a1 =new Integer[4];
        //OR
        Integer[] a2 =new List<Integer>();
        //OR
        List<Integer> a3 =new Integer[4];
        //adding values using Array Notation
        a3[0]=22;
        a3[1]=44;
        System.debug(a3);
        // Accessing Nth Element of a List
        System.debug(a3[2]);
    }
    
    public static void listMethods()
    {
        List<Integer> l1 = new List<Integer>();
        l1.add(2);
        l1.add(4);
        l1.add(6);
        l1.add(8);
        
        System.debug('List Values: '+l1);
        
        System.debug('List Size : '+l1.size());
        System.debug('List Get : '+l1.get(2));
        System.debug('List Removed index 2 value is 6 : '+l1.remove(2));
        System.debug('List Values: '+l1);
        
        List<Integer> l2 = l1.clone();
        System.debug('Cloned Values of l1 : '+l2);
        
        //Arithmetic expressions are not allowed on void types
        /* System.debug('Set Values : '+ l2.set(1,6));
        System.debug('Sort Values :'+l2.sort());
		System.debug('Is Empty true or false :'+l2.isEmpty());
        System.debug('clear the list : '+l2.clear()); */
        // set() → returns old value
    
        l2.set(1, 6);
        System.debug('After set(): ' + l2);
        
        // sort() → void
        l2.sort();
        System.debug('After sort(): ' + l2);
        
        // isEmpty() → Boolean
        System.debug('Is Empty true or false : ' + l2.isEmpty());
        
        // clear() → void
        l2.clear();
        System.debug('After clear(): ' + l2);        
    }
    
    public static void mySetInitialization()
    {
        Set<Integer> s1 = new Set<Integer>();
        
        s1.add(10);
        s1.add(20);
        s1.add(30);
        s1.add(10);
        
        System.debug('Set values s1: '+s1);
        System.debug('set size s1 :'+s1.size());
        
        Set<String> s2 = new Set<String>{'My','Name','is','doll' };
        System.debug('Set values s2: '+s2);
        System.debug('set size s2 :'+s2.size());
        
        //Unique of sObjects
        //While inserting Even thaough we have 4 sobject but the set check the field value uniquness
        // not based on the sobejct so it removes a1 or a4 only keep 1 as its exactly Same
        // Uniquesness of set is defined pased on the values of the field
        Set<Account> aSet = new Set<Account>();
        
        Account a1 = new Account(Name = 'Amazon',Cities__c ='Bangalore');
        Account a2 = new Account(Name = 'Walmart',Cities__c ='Bangalore');
        Account a3 = new Account(Name = 'Amazon',Cities__c ='Bangalore');
        Account a4 = new Account(Name = 'Amazon');
        
        System.debug('Set Size: ' + aSet.size());
        // Add all in one line
        aSet.addAll(new List<Account>{ a1, a2, a3, a4 });
        
        System.debug('Set Size: ' + aSet.size());
        System.debug('Set Values: ' + aSet);
    }
    
    public static void myMapInitialization()
    {
        Map<Integer,String> m1 =  new Map<Integer,String>();
        
        m1.put(1,'John');
        m1.put(2,'Don');
        System.debug('Map Values: '+m1);
        System.debug('Map Size :'+m1.size());
        
        Map<Integer,String> m2 =  new Map<Integer,String>{4=>'Jemmy',5=>'David'};
        System.debug('Map Values: '+m2);
        System.debug('Map Size :'+m2.size());
    }

    public static void mapMethods()
    {
        Map<Integer,String> m1 =  new Map<Integer,String>{1=>'Don'};
        
        Map<Integer,String> m2 =  new Map<Integer,String>{4=>'Jemmy',5=>'David'};
            
        m1.putAll(m2);
        System.debug(m1);
        
        System.debug(m1.get(2));
        System.debug(m1.get(4));
        
        //To get the Map Values inside the List /List Formate
        List<String> l1 = new List<String>();
        l1=m1.values();
        System.debug('Map -> List Values : '+l1);
        
        List<Integer> l2 = new List<Integer>(m1.keySet());
		System.debug('Map -> List Keyset : '+l2);
        
        Map<Integer,String> m3 =  new Map<Integer,String>();
		m3 =m2.clone();
        System.debug('Cloned Values m1 :'+m3);
        System.debug('Is Empty :'+m3.isEmpty());
        m3.Remove(4);
        System.debug('After remove 4 ;'+m3);
        m3.clear();
        System.debug('After Clear'+m3);
    }
}