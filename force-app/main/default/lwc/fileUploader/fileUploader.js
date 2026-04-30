import { LightningElement, track } from 'lwc';
import processCSV from '@salesforce/apex/AppointmentUpdater.processCSV';

export default class CsvUploader extends LightningElement {

    file;
    @track result;
    @track fileName;

    handleFile(event) {
        this.file = event.target.files[0];

        if (this.file) {
            this.fileName = this.file.name;
        }
    }

    uploadFile() {

        if (!this.file) {
            this.result = 'Select a file first';
            return;
        }

        const reader = new FileReader();

        reader.onload = () => {

            let csvText = reader.result;

            // Normalize line endings
            csvText = csvText.replace(/\r\n/g, '\n');

            processCSV({ csvData: csvText })
                .then(res => {
                    this.result = res;
                })
                .catch(err => {
                    this.result = err.body.message;
                });
        };

        // ⭐ IMPORTANT — read as TEXT
        reader.readAsText(this.file);
    }
}