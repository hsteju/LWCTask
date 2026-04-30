public with sharing class AppointmentUpdater {

    @AuraEnabled
    public static String processCSV(String csvData) {

        if (String.isBlank(csvData)) {
            return 'CSV file is empty';
        }

        List<String> rows = csvData.split('\n');
        if (rows.size() < 2) {
            return 'CSV has no data rows';
        }

        // Detect separator
        String sep = rows[0].contains('\t') ? '\t' : ',';

        // Parse headers
        List<String> headers =
            rows[0].replace('\r','').split(sep);

        Map<String,Integer> headerMap =
            new Map<String,Integer>();

        for(Integer i=0;i<headers.size();i++){
            headerMap.put(headers[i].trim(), i);
        }

        // Header validation
        if(!headerMap.containsKey('AppointmentNumber') ||
           !headerMap.containsKey('ServiceResources') ||
           !headerMap.containsKey('SchedStartTime')){

            return 'Invalid headers.\nExpected:\n' +
                   'AppointmentNumber, ServiceResources, SchedStartTime';
        }

        Set<String> apptNums = new Set<String>();
        Set<String> techNames = new Set<String>();

        // Collect values
        for(Integer i=1;i<rows.size();i++){

            if(String.isBlank(rows[i])) continue;

            List<String> cols =
                rows[i].replace('\r','').split(sep);

            if(cols.size() < headers.size()) continue;

            apptNums.add(
                cols[headerMap.get('AppointmentNumber')].trim()
            );

            techNames.add(
                cols[headerMap.get('ServiceResources')].trim()
            );
        }

        // Query appointments
        Map<String,ServiceAppointment> apptMap =
            new Map<String,ServiceAppointment>();

        for(ServiceAppointment sa : [
            SELECT Id, AppointmentNumber, SchedStartTime, Status
            FROM ServiceAppointment
            WHERE AppointmentNumber IN :apptNums
        ]){
            apptMap.put(sa.AppointmentNumber, sa);
        }

        // Query service resources
        Map<String,ServiceResource> techMap =
            new Map<String,ServiceResource>();

        for(ServiceResource sr : [
            SELECT Id, Name
            FROM ServiceResource
            WHERE Name IN :techNames
        ]){
            techMap.put(sr.Name, sr);
        }

        List<ServiceAppointment> updates =
            new List<ServiceAppointment>();

        List<String> errors = new List<String>();

        // Process rows
        for(Integer i=1;i<rows.size();i++){

            if(String.isBlank(rows[i])) continue;

            Integer rowNum = i+1;

            List<String> cols =
                rows[i].replace('\r','').split(sep);

            if(cols.size() < headers.size()){
                errors.add('Row '+rowNum+': Column mismatch');
                continue;
            }

            String apptNum =
                cols[headerMap.get('AppointmentNumber')].trim();

            String tech =
                cols[headerMap.get('ServiceResources')].trim();

            String dateStr =
                cols[headerMap.get('SchedStartTime')].trim();

            // Validate appointment
            if(!apptMap.containsKey(apptNum)){
                errors.add('Row '+rowNum+
                    ': Appointment not found → '+apptNum);
                continue;
            }

            // Validate technician
            if(!techMap.containsKey(tech)){
                errors.add('Row '+rowNum+
                    ': Technician not found → '+tech);
                continue;
            }

            // Parse DD-MM-YYYY
            Date newDate;

            try{
                List<String> d = dateStr.split('-');

                newDate = Date.newInstance(
                    Integer.valueOf(d[2]),
                    Integer.valueOf(d[1]),
                    Integer.valueOf(d[0])
                );
            }
            catch(Exception e){
                errors.add('Row '+rowNum+
                    ': Invalid date → '+dateStr);
                continue;
            }

            ServiceAppointment sa =
                apptMap.get(apptNum);

            // Preserve time
            DateTime oldDT = sa.SchedStartTime;

            Integer h = oldDT!=null ? oldDT.hour() : 0;
            Integer m = oldDT!=null ? oldDT.minute() : 0;
            Integer s = oldDT!=null ? oldDT.second() : 0;

            sa.SchedStartTime =
                DateTime.newInstance(
                    newDate.year(),
                    newDate.month(),
                    newDate.day(),
                    h,m,s
                );

            // FORCE STATUS
            sa.Status = 'Dispatched';

            updates.add(sa);
        }

        if(!updates.isEmpty()){
            update updates;
        }

        String result =
            updates.size()+' appointments dispatched';

        if(!errors.isEmpty()){
            result += '\nErrors:\n'+
                String.join(errors,'\n');
        }

        return result;
    }
}