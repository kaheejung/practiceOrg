@isTest
private class AddPrimaryContactTest {
	
	@testSetup static void test_method_one() {
		// Implement test code
		List<Account> accounts = new List<Account>();
		for(Integer i = 0; i < 50; i++){
			Account obj = new Account();
			obj.Name = 'Account ' + i;
			obj.BillingState = 'NY';
			accounts.add(obj);
		}

		for(Integer i = 50; i < 100; i++){
			Account obj = new Account();
			obj.Name = 'Account ' + i;
			obj.BillingState = 'CA';
			accounts.add(obj);	
		}

		Insert accounts;
	}

	static testmethod void testMe(){
		Test.startTest();

		Contact contact = new Contact(LastName='LastName', FirstName='FirstName');

		AddPrimaryContact con = new AddPrimaryContact(contact, 'CA');
		System.enqueueJob(con);
		Test.stopTest();
	}
		
}