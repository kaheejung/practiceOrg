@isTest
private class AnimalLocatorTest {
	
	@isTest static void test_method_one() {
		// Implement test code
		Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
		
		String name = AnimalLocator.getAnimalNameById(2);
		
		system.assertEquals('bear', name);

	}
}