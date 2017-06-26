/*
 * This is the TriggerSwitch class. Its purpose is to interrogate the Trigger Disablers custom metadata type
 * to determine whether a given trigger has been disabled.
 * 
 * It is not intended to be instantiated, static use only. 
 * 
*/

public class TriggerSwitch {
    private TriggerSwitch() {}
    
    // method we can call using separate notation, i.e.
    // TriggerSwitch.isEnabled('MyTrigger','myHandlerItem')
    
    public static boolean isTriggerEnabled(String triggerName) {
        
        // we assume the trigger is enabled to start with
        
        boolean enabled = true;
        
        // get any custom metadata for this particular trigger name/method name
        
        List<Trigger_Disabler__mdt> triggerDisablers = 
            [SELECT Trigger_Name__c, Method_name__c, Disabled__c 
             FROM Trigger_Disabler__mdt 
             WHERE Trigger_Name__c = :triggerName
               AND Method_name__c = 'global'];
        
        // if we find anything for that trigger, we keep looking, else assume it's enabled
        
        if (triggerDisablers.size() != 0) {

            System.debug(LoggingLevel.FINE, 'Found ' + triggerDisablers.size() + ' matching metadata records.');
            
            // iterate over any records to check if we have one with the disabled flag set
            // if so, we disable the trigger, else assume it's enabled
            
            for (Trigger_Disabler__mdt td : triggerDisablers) {
                if (td.Disabled__c == true) {
                    enabled = false;
                }
            }
        }
        
        // now return whatever we found

        System.debug(LoggingLevel.DEBUG, 'TriggerSwitch - trigger ' + triggerName + ':' + (enabled ? 'ENABLED' : 'DISABLED'));       
    	return enabled;
    }
    
    public static boolean isHandlerEnabled(String triggerHandlerName, String methodName) {
        
        // we assume the trigger is enabled to start with
        
        boolean enabled = true;
        
        // get any custom metadata for this particular trigger name/method name
        
        List<Trigger_Disabler__mdt> triggerDisablers = 
            [SELECT Trigger_Name__c, Method_name__c, Disabled__c 
             FROM Trigger_Disabler__mdt 
             WHERE Trigger_Name__c = :triggerHandlerName
               AND Method_name__c = :methodName];
        
        // if we find anything for that trigger, we keep looking, else assume it's enabled
        
        if (triggerDisablers.size() != 0) {
            
            // iterate over any records to check if we have one with the disabled flag set
            // if so, we disable the trigger, else assume it's enabled
            
            for (Trigger_Disabler__mdt td : triggerDisablers) {
                if (td.Disabled__c == true) {
                    enabled = false;
                }
            }
        }
        
        // now return whatever we found
        
        System.debug(LoggingLevel.DEBUG, 'TriggerSwitch - trigger handler ' + triggerHandlerName + '.' + methodName + ':' + (enabled ? 'ENABLED' : 'DISABLED'));
    	return enabled;
    }
}