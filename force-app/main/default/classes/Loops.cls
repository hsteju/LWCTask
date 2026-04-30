public class Loops {
    public static void myWhileLoop()
    {
        /* WHILE LOOP
            while(COndition)
            {
                Write the code in this block which you want 
                to execute until the condition return false
				Means it will execute if condition is true 
            }
       */
        
        Integer n=1;
        while(n<=5)  // first check cond then if true the execute
        {
            System.debug('Value of i :'+n);
            n++;
        }   
    }
    
    public static void mydowhileLoop()
    {
        /* do
            {
            	 Write the code in this block which you want 
                to execute until the condition return false
            }
            while(Condition)
            {
            
            }

            The Major difference is 
            1. While is Entry controlled and do while is exit controlled loop.
            2. do while will execute at least irrespective of the condition where
			   as the while will only execute if the condition status is true
		*/
        Integer n = 2;
			// // first execute , then check condition ,if true then execute 
        do {
            System.debug('Execute once before checking condition: ' + n);
            n++;   // increment inside loop
        } while (n == 2);
        
        System.debug('After loop, value of n: ' + n);

    }

    public static void myforLoop()
    {
        /* for( Initialization ; Condition ; Increment/decrement )
            {
            	Write the code in this block which you want 
                to execute until the condition return false
            }
		*/
         
        // 1st initialize,then check condition ,
        //  then execute the loop then incre/decre, 
        // then check cond,
        // same loop goes on till condition becomes false
        for (Integer n =0 ; n<5 ; n++)
        {
            System.debug('for loop : '+n);
        }
    }
    
    public static void myforEachLoop()
    {
     /* for(Variable : List or set)
        {
            Write the code in this block which you want 
            to execute until the condition return false
			for each loop is used to iterate through all elements of the list or set
        }
	  */
        
        // List<Integer> iList = new List<Integer>{1,2,3,4,5,6,7,8}; or 
        Integer sum =0;
        List<Integer> iList = new Integer[]{1,2,3,4,5,6,7,8};
        for(Integer i : iList)
        {
            System.debug(i);
        }
        
    }
    
}