public class ConditionalStatements {
    public static void ifStatement()
    {
        /* if(Cond which returns true or false)
            {
            	Code executes if cond is true
            }
		*/
        integer sum = 1000;
        
        if(sum == 1000)
        {
            System.debug('if Cndition :'+sum);
        }
        
        if(sum == 100)
        {
            System.debug('if Cndition :'+sum);
        }
        System.debug('@nd if cond is false so no exce');
        
    }
    
    public static void ifelseStatement()
    {
        /* if(Cond which returns true or false)
            {
            	Code executes if cond is true
            }
		*/
        
        integer sum = 1000;
        
        if(sum == 100)
        {
            System.debug('if Cndition :'+sum);
        }
        else
        {
            System.debug('If does not satasify so els will run');
        }
    }
    
    public static void if_Elseif_elseStatement()
    {
        /*if(Cond1 which returns true or false)
            {
            	Code executes if cond is true
            }
            else if(Cond2 executes if above con1 is false if this is T)
                        {
                            Code executes if cond is true
                        }
            if(Cond3 executes if above con1 and con2 is false if this is T)
                        {
                            Code executes if cond is true
                        }
            else
            {
            // if non above true this will execute
            }
         
         */
         Integer marks = 70;

            if (marks >= 90) {
                System.debug('Grade A');
            } else if (marks >= 60) {
                System.debug('Grade B');
            } else {
                System.debug('Grade C');
            }

    }
    
     public static void switch()
     {
         // The switch statement is used to execute one block of code from multiple
         Integer score = 85;

            switch on score {
                when 90, 95, 100 {
                    System.debug('Excellent');
                }
                when 75, 80, 85 {
                    System.debug('Very Good');
                }
                when else {
                    System.debug('Good');
                }
            }

        }
}