@isTest
private class TriggerSwitch_Test {
	
	/*
	 * Test of isTriggerEnabled 1
	 * Given that we have a disabler record for TestingTrigger with the global method name and disabled set
	 * We expect that checking for disablement of TestingTrigger should return that the trigger is disabled
	 */

	@isTest static void test_isTriggerEnabled1() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isTriggerEnabled('TestingTrigger');

		Test.stopTest();

		System.assert(enabled == false, 'Expecting TestingTrigger to be disabled due to custom metadata record, but apparently not...');
	}

	/*
	 * Test of isTriggerEnabled 2
	 * Given that we have a disabler record for TestingTrigger2 with the global method name and disabled not set
	 * We expect that checking for disablement of TestingTrigger2 should return that the trigger is enabled
	 */

	@isTest static void test_isTriggerEnabled2() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isTriggerEnabled('TestingTrigger2');

		Test.stopTest();

		System.assert(enabled == true, 'Expecting TestingTrigger2 to be enabled due to custom metadata record with disabled flag unset, but apparently not...');
	}	

	/*
	 * Test of isTriggerEnabled 3
	 * Given that we don't have a disabler record for TestingTrigger3
	 * We expect that checking for disablement of TestingTrigger3 should return that the trigger is enabled
	 */

	@isTest static void test_isTriggerEnabled3() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isTriggerEnabled('TestingTrigger3');

		Test.stopTest();

		System.assert(enabled == true, 'Expecting TestingTrigger3 to be enabled due to missing custom metadata record, but apparently not...');
	}	

	/*
	 * Test of isTriggerEnabled 4
	 * Given that we have a disabler record for TestingTrigger4 with the method name something else than global and disabled set
	 * We expect that checking for disablement of TestingTrigger4 should return that the trigger is enabled (because the method name is not global)
	 */

	@isTest static void test_isTriggerEnabled4() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isTriggerEnabled('TestingTrigger4');

		Test.stopTest();

		System.assert(enabled == true, 'Expecting TestingTrigger4 to be enabled due to custom metadata record with method name not global, but apparently not...');
	}	
	
	/*
	 * Test of isHandlerEnabled 1
	 * Given that we have a disabler record for TestingHandler with the method name method1 and disabled set
	 * We expect that checking for disablement of TestingHandler.method1 should return that the trigger is disabled
	 */

	@isTest static void test_isHandlerEnabled1() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isHandlerEnabled('TestingHandler','method1');

		Test.stopTest();

		System.assert(enabled == false, 'Expecting TestingHandler.method1 to be disabled due to custom metadata record, but apparently not...');
	}
	
	/*
	 * Test of isHandlerEnabled 2
	 * Given that we have a disabler record for TestingHandler with the method name method2 and disabled not set
	 * We expect that checking for disablement of TestingHandler.method2 should return that the trigger is enabled
	 */

	@isTest static void test_isHandlerEnabled2() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isHandlerEnabled('TestingHandler','method2');

		Test.stopTest();

		System.assert(enabled == true, 'Expecting TestingHandler.method2 to be enabled due to custom metadata record, but apparently not...');
	}

	/*
	 * Test of isHandlerEnabled 3
	 * Given that we don't have a disabler record for TestingHandler with the method name method3 
	 * We expect that checking for disablement of TestingHandler.method3 should return that the trigger is enabled
	 */

	@isTest static void test_isHandlerEnabled3() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isHandlerEnabled('TestingHandler','method3');

		Test.stopTest();

		System.assert(enabled == true, 'Expecting TestingHandler.method3 to be enabled due to custom metadata record, but apparently not...');
	}

	/*
	 * Test of isHandlerEnabled 4
	 * Given that we don't have a disabler record for SomeOtherTestingHandler
	 * We expect that checking for disablement of SomeOtherTestingHandler.method3 should return that the trigger is enabled
	 */

	@isTest static void test_isHandlerEnabled4() {
		Test.startTest();

		boolean enabled = TriggerSwitch.isHandlerEnabled('SomeOtherTestingHandler','method3');

		Test.stopTest();

		System.assert(enabled == true, 'Expecting SomeOtherTestingHandler.method3 to be enabled due to custom metadata record, but apparently not...');
	}

}