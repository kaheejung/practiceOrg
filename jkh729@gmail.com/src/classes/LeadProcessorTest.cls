@isTest
private class LeadProcessorTest {
	@testSetup static void setup(){
		List<Lead> leads = new List<Lead>();

		for(Integer i = 0; i <  10; i++){
			leads.add(new Lead(firstName = 'first ' + i, lastName = 'last ' + i, Company = 'Company ' + i));
		}

		Insert leads;
	}

	@isTest static void test_method_one() {
		// Implement test code
		
		Test.startTest();
			LeadProcessor lp = new LeadProcessor();
			Id batchId = Database.executeBatch(lp);
		Test.stopTest();
	}
}