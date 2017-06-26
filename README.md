# TriggerDisabler
This is a small APEX feature library that implements a custom metadata and a util class to be used as a switch to implement in your trigger code to allow it to be controlled/disabled using the custom metadata object.

The way it's supposed to work is that you add a line of code to your triggers and/or trigger handler methods that subsequently allows them to be disabled at need by adding custom metadata in the `Trigger_Disabler__mdt` custom metadata object.

So your code would look something like this:

```java
trigger AccountTrigger on Account (after insert, after update) {
    // Check if the trigger is enabled first
    if (TriggerSwitch.isTriggerEnabled('AccountTrigger')) {
        if(Trigger.isAfter && Trigger.isInsert) {
            AccountTriggerHandler.handleAfterInsert(Trigger.new);
        } else if(Trigger.isAfter && Trigger.isUpdate) {
            AccountTriggerHandler.handleAfterUpdate(Trigger.new, Trigger.old);
        }
    }   
}

public class AccountTriggerHandler {
    public static void handleAfterInsert(List accts) {
        doThis(accts);
        doThat(accts);
    }
    private static void doThis(List accts) {
        // check if top-level handler method is enabled first
        if (TriggerSwitch.isHandlerEnabled('AccountTrigger','doThis')) {
            // ... your actual logic here
        }
    }
}
```
And you would be adding a `Trigger_Disabler__mdt` custom metadata object with `Trigger_Name__c = 'AccountTrigger'`, `Method_name__c = 'doThis'` and `Disabled__c = true` to ensure that your doThis method in the trigger handler never did anything as long as that custom metadata item was there. Flipping the `Disabled__c` field to false or plain removing the whole custom metadata record would mean that `doThis` method does its thing without a hitch.

Likewise, to disable a trigger globally, you'd me adding a `Trigger_Disabler__mdt` custom metadata object with `Trigger_Name__c = 'AccountTrigger'`, `Method_name__c = 'global'` and `Disabled__c = true`. This would trip the switch in the trigger itself. 