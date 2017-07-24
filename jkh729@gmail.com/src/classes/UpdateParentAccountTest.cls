@isTest
private class UpdateParentAccountTest {
	
	@testSetup static void setup() {
		// Implement test code
		List<Account> accounts = new List<Account>();
		accounts.add(new Account(Name='Parent'));

		for(Integer i = 0; i < 100; i++){
			accounts.add(new Account(name='Test Account' + i));
		}

		Insert accounts;
	}
	

	static testmethod void testQueueable(){
		Id parentId = [SELECT Id FROM Account WHERE Name = 'Parent'][0].Id;
		List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name like 'Test Account%'];
		UpdateParentAccount updater = new UpdateParentAccount(accounts, parentId);

		Test.startTest();
		System.enqueueJob(updater);
		Test.stopTest();

		System.assertEquals(100, [SELECT count() FROM Account WHERE parentId = :parentId]);
	}
	
}