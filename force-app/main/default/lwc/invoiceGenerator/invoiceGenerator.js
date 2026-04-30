import { LightningElement, api, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import getOpportunity from '@salesforce/apex/InvoiceController.getOpportunity';
import getProducts from '@salesforce/apex/InvoiceController.getProducts';
import saveInvoice from '@salesforce/apex/InvoiceController.saveInvoice';

import logo from '@salesforce/resourceUrl/invoiceLogo';
import jspdfLib from '@salesforce/resourceUrl/jspdf';
import autoTableLib from '@salesforce/resourceUrl/jspdfautotable';

import { loadScript } from 'lightning/platformResourceLoader';

export default class InvoiceGenerator extends NavigationMixin(LightningElement) {

    @api recordId;

    step = 1;
    opportunityName;

    @track products = [];
    @track lineItems = [];

    logo = logo;
    jsLoaded = false;

    // LOAD SCRIPTS
    connectedCallback() {
        Promise.all([
            loadScript(this, jspdfLib),
            loadScript(this, autoTableLib)
        ])
        .then(() => {
            this.jsLoaded = true;
        })
        .catch(err => console.error(err));
    }

    // GET OPPORTUNITY
    @wire(getOpportunity, { oppId: '$recordId' })
    wiredOpp({ data }) {
        if (data) {
            this.opportunityName = data.Name;
        }
    }

    // GET PRODUCTS
    @wire(getProducts)
    wiredProd({ data }) {
        if (data) this.products = data;
    }

    get productOptions() {
        return (this.products || []).map(p => ({
            label: p.Name,
            value: p.Name
        }));
    }

    // STEP CONTROL
    get isStepOne() { return this.step === 1; }
    get isStepTwo() { return this.step === 2; }

    nextStep() { this.step = 2; }
    previousStep() { this.step = 1; }

    // ADD LINE
    addLineItem() {
        this.lineItems = [
            ...this.lineItems,
            {
                id: Date.now(),
                productName: '',
                quantity: 1,
                price: 0,
                total: 0
            }
        ];
    }

    // HANDLE CHANGE
    handleChange(event) {
        const i = event.target.dataset.index;
        const field = event.target.dataset.field;
        const value = event.target.value;

        this.lineItems[i][field] = value;

        const qty = Number(this.lineItems[i].quantity || 0);
        const price = Number(this.lineItems[i].price || 0);

        this.lineItems[i].total = qty * price;

        this.lineItems = [...this.lineItems];
    }

    // TOTAL
    get totalAmount() {
        return this.lineItems.reduce((s, i) => s + Number(i.total || 0), 0);
    }

    // SAVE + PDF
    saveInvoice() {
        saveInvoice({
            opportunityId: this.recordId,
            lines: this.lineItems
        })
        .then(id => {
            this.toast('Success', 'Invoice Created', 'success');
            this.generatePDF(id);
            this.navigate(id);
        })
        .catch(err => {
            this.toast('Error', err.body?.message, 'error');
        });
    }

    // FORMAT
    formatCurrency(val) {
        return Number(val).toLocaleString('en-IN');
    }

    // CONVERT LOGO
    getBase64Image(imgUrl) {
        return fetch(imgUrl)
            .then(res => res.blob())
            .then(blob => new Promise(resolve => {
                const reader = new FileReader();
                reader.onloadend = () => resolve(reader.result);
                reader.readAsDataURL(blob);
            }));
    }

    // GENERATE PDF (PROFESSIONAL)
    async generatePDF(id) {

        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        const logoBase64 = await this.getBase64Image(this.logo);

        // LOGO
        doc.addImage(logoBase64, 'PNG', 80, 10, 50, 20);

        // TITLE
        doc.setFontSize(22);
        doc.setFont("helvetica", "bold");
        doc.text("INVOICE", 105, 40, { align: "center" });

        // OPPORTUNITY
        doc.setFontSize(11);
        doc.setFont("helvetica", "normal");
        doc.text(`Opportunity: ${this.opportunityName}`, 14, 55);

        // TABLE DATA
        const tableData = this.lineItems.map(item => [
            item.productName,
            item.quantity,
            `INR ${this.formatCurrency(item.price)}`,
            `INR ${this.formatCurrency(item.total)}`
        ]);

        // TABLE
        doc.autoTable({
            startY: 65,
            head: [['Product', 'Qty', 'Price', 'Total']],
            body: tableData,
            styles: {
                fontSize: 10
            },
            headStyles: {
                fillColor: [0, 0, 0]
            },
            columnStyles: {
                1: { halign: 'right' },
                2: { halign: 'right' },
                3: { halign: 'right' }
            }
        });

        // TOTAL
        const finalY = doc.lastAutoTable.finalY;

        doc.setFontSize(12);
        doc.setFont("helvetica", "bold");

        doc.text(
            `Grand Total: INR ${this.formatCurrency(this.totalAmount)}`,
            14,
            finalY + 15
        );

        // FOOTER
        doc.setFontSize(9);
        doc.setFont("helvetica", "normal");

        doc.text(
            "Thank you for your business!",
            105,
            285,
            { align: "center" }
        );

        doc.save(`Invoice_${id}.pdf`);
    }

    // NAVIGATE
    navigate(id) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: id,
                actionName: 'view'
            }
        });
    }

    // TOAST
    toast(t, m, v) {
        this.dispatchEvent(new ShowToastEvent({
            title: t,
            message: m,
            variant: v
        }));
    }
}