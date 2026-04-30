trigger InvoiceLineTrigger on InvoiceLine (
    after insert, after update, after delete, after undelete
) {
    Set<Id> invoiceIds = new Set<Id>();

    // Collect invoice IDs from new records
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (InvoiceLine line : Trigger.new) {
            if (line.InvoiceId != null) {
                invoiceIds.add(line.InvoiceId);
            }
        }
    }

    // Collect invoice IDs from old records (for delete)
    if (Trigger.isDelete) {
        for (InvoiceLine line : Trigger.old) {
            if (line.InvoiceId != null) {
                invoiceIds.add(line.InvoiceId);
            }
        }
    }

    if (invoiceIds.isEmpty()) return;

    // Aggregate SUM of UnitPrice grouped by InvoiceId
    Map<Id, Decimal> invoiceSums = new Map<Id, Decimal>();
    for (AggregateResult ar : [
        SELECT InvoiceId Id, SUM(UnitPrice) total
        FROM InvoiceLine
        WHERE InvoiceId IN :invoiceIds
        GROUP BY InvoiceId
    ]) {
        invoiceSums.put((Id)ar.get('Id'), (Decimal)ar.get('total'));
    }

    // Update parent Invoices
    List<Invoice> invoicesToUpdate = new List<Invoice>();
    for (Id invId : invoiceIds) {
        invoicesToUpdate.add(new Invoice(
            Id = invId,
            Total_Amount_Custom__c = invoiceSums.containsKey(invId) ? invoiceSums.get(invId) : 0
        ));
    }

    if (!invoicesToUpdate.isEmpty()) {
        update invoicesToUpdate;
    }
}