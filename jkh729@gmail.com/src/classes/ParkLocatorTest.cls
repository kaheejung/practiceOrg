@isTest
private class ParkLocatorTest {
	
	@isTest static void parkLocatorCalloutTest() {
		// Implement test code
		Test.setMock(WebServiceMock.class, new ParkServiceMock());
		String country = 'United States';
		ParkLocator.country(country);

	}
	
}