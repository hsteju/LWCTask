trigger TriggerPractise on Account (before insert,before update) {
    if(Trigger.isInsert){
        System.debug('Size :'+Trigger.size); // Size of the inserted record is 1 When we insert Manually and mass Inset will show differenr
        //System.debug('New Records :'+Trigger.NEW); // the new Values which we insert
        //System.debug('Old Records :'+Trigger.OLD); // Old Values Will be NULL
        
        System.debug('New Records :'+Trigger.newMap); // the new Values which we insert
        System.debug('Old Records :'+Trigger.oldMap);
    }
    else if(Trigger.isUpdate){
        System.debug('Updated New Records :'+Trigger.NEW); // The Updated Values
        System.debug('Updated Old Records :'+Trigger.OLD); // the Existing Values
    }
    

}