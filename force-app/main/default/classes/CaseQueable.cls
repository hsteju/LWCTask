public class CaseQueable implements Queueable {

    private Id caseId;

    public CaseQueable(Id cId) {
        this.caseId = cId;
    }

    public void execute(QueueableContext context) {
        // Fetch Case details
        Case c = [
            SELECT Id, OwnerId, Status, IsClosed, ClosedDate
            FROM Case
            WHERE Id = :caseId
            LIMIT 1
        ];

        if (c.IsClosed && c.ClosedDate != null) {
            // Create Task dynamically
            sObject t = Schema.getGlobalDescribe().get('Task').newSObject();
            t.put('WhatId', c.Id);
            t.put('OwnerId', c.OwnerId);
            t.put('Subject', 'Follow-up after escalation');
            t.put('ActivityDate', c.ClosedDate.addDays(30));
            t.put('Status', 'Not Started');
            t.put('Priority', 'Normal');

            Database.insert(t);
        }
    }
}