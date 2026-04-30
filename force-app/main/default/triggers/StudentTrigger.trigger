trigger StudentTrigger on Student__c (before Update) 
{
    // append Limited to the name 
    Student__c s = Trigger.new[0];
    s.Name= s.Name+ 'Limited';
    
    
	
	
}