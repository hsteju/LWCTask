declare module "@salesforce/apex/InvoiceController.getOpportunity" {
  export default function getOpportunity(param: {oppId: any}): Promise<any>;
}
declare module "@salesforce/apex/InvoiceController.getProducts" {
  export default function getProducts(): Promise<any>;
}
declare module "@salesforce/apex/InvoiceController.saveInvoice" {
  export default function saveInvoice(param: {opportunityId: any, lines: any}): Promise<any>;
}
