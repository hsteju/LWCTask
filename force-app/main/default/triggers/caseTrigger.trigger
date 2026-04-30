trigger caseTrigger on Case (after update) {
    for (Case c : Trigger.new) {
        Case oldcase = Trigger.oldMap.get(c.Id);

        if (c.IsEscalated == true && c.IsClosed == true && oldcase.IsEscalated == false) {
            System.enqueueJob(new CaseQueable(c.Id));
        }
    }
}