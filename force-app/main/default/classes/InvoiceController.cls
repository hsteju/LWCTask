public with sharing class InvoiceController {

    @AuraEnabled(cacheable=true)
    public static Opportunity getOpportunity(Id oppId) {

        return [
            SELECT Id, Name
            FROM Opportunity
            WHERE Id = :oppId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Product2> getProducts() {

        return [
            SELECT Id, Name
            FROM Product2
            WHERE IsActive = true
            LIMIT 50
        ];
    }

    @AuraEnabled
    public static Id saveInvoice(Id opportunityId, List<InvoiceLineWrapper> lines) {

        InvoiceCustom__c inv = new InvoiceCustom__c();
        inv.Name = 'INV-' + Datetime.now().getTime();
        inv.Opportunity__c = opportunityId;

        insert inv;

        List<Invoice_Line_Custom__c> items = new List<Invoice_Line_Custom__c>();

        Decimal total = 0;

        for (InvoiceLineWrapper l : lines) {

            Invoice_Line_Custom__c line = new Invoice_Line_Custom__c();

            line.InvoiceCustom__c = inv.Id;
            line.Product_Name__c = l.productName;
            line.Quantity__c = l.quantity;
            line.Price__c = l.price;

            Decimal lineTotal =
                (l.quantity == null ? 0 : l.quantity) *
                (l.price == null ? 0 : l.price);

            line.Total__c = lineTotal;

            total += lineTotal;

            items.add(line);
        }

        insert items;

        inv.Total_Amount__c = total;
        update inv;

        return inv.Id;
    }

    public class InvoiceLineWrapper {
        @AuraEnabled public String productName;
        @AuraEnabled public Decimal quantity;
        @AuraEnabled public Decimal price;
        @AuraEnabled public Decimal total;
    }
}