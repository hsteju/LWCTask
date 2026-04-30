trigger TaskTrigger on Task (before insert) {
    /*
    // Whenever a Task is created, set the priority to high
    // If i want to update in the Same Record
    
    if (Trigger.isInsert && Trigger.isBefore) {
        for (Task taskRecord : Trigger.new) {
            System.debug('Task Record created');
            taskRecord.Priority = 'High'; 
        }
    }
*/
}