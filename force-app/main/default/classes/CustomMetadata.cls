public class CustomMetadata {
    public static Decimal customMetadata(String region)
    {
        Decimal priceingPrirotyIndex = 0;
        // Axcess the metadata
        // when i access my metadata record ,I want to fetch the priceing field 
        // value for the record whose region name is matching my method parameter
        
        if (String.isNotBlank(region)) {
            List<Inventory_priceing__mdt> priceingmdt = [SELECT Id, DeveloperName, MasterLabel, Language ,Pricing__c 
                                                             FROM Inventory_priceing__mdt 
                                                             WHERE Region__c = :region Limit 1];
                if(priceingmdt.size() == 1)
                {
                   priceingPrirotyIndex = priceingmdt[0].Pricing__c;
                }  
                else{
                    System.debug('Invalid Region');
                }
            }
        return priceingPrirotyIndex;
    }
}