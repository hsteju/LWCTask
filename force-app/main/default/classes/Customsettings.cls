public class Customsettings {
    public static Decimal customSettings() {
        // Decimal taxPricingInformation = 0; // Initialize to avoid null return
        
        // Access the custom settings and return the Taxpricing Information
        // Here we don't need to hit the Governor Limit because
        // It is stored in Cache
        // How to access the Custom Settings
        
        System.debug('Org Default Values: ' + Inventory_Priceing_Priority__c.getOrgDefaults()); // Org Values
        // User Values from here based on User who has logged in 
        System.debug('Instance Defaults: ' + Inventory_Priceing_Priority__c.getInstance());
        System.debug('Instance Defaults: ' + Inventory_Priceing_Priority__c.getInstance(UserInfo.getUserId()));
        System.debug('Values Defaults: ' + Inventory_Priceing_Priority__c.getValues(UserInfo.getUserId()));
        
        // Query to get the user Id
        User userRecord = [SELECT Id FROM User WHERE Name = 'Adam Perk' LIMIT 1];
        Id userId = userRecord.Id;
        System.debug('userId: ' + userId);
        System.debug('Instance Defaults for user: ' + Inventory_Priceing_Priority__c.getInstance(userId));
        // 222
        return 0;
    }
    
    // Based on the currently Loged in User
    public static Decimal customSettingsList() {
    // Check if UserId is a part of the custom settings or not
    // If it's a part then I can access getValues() = UserSpecific
    // If it is not a part, access org Default Info
    Id userId = UserInfo.getUserId();
    Inventory_Priceing_Priority__c ips = Inventory_Priceing_Priority__c.getValues(userId);
    
    if (ips != null) {
        return ips.Tax_Priceing__c; // Replace with the actual field name you want to return
    } else {
        return Inventory_Priceing_Priority__c.getOrgDefaults().Tax_Priceing__c;
    }
}

}