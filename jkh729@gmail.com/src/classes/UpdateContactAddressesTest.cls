@isTest
private class UpdateContactAddressesTest {
	
	@testSetup static void setup() {
		// Implement test code
		List<Account> accounts = new List<Account>();
		List<Contact> contacts = new List<Contact>();
		
		for(Integer i = 0; i < 10; i++){
			accounts.add(new Account(name='Account ' + i, BillingCity='New York', billingcountry='USA'));
		}

		insert accounts;

		for(Account account : [SELECT id FROM Account]){
			contacts.add(new Contact(firstName='first', lastName='last', accountId=account.Id));
		}

		insert contacts;
	}

	static testmethod void test(){
		Test.startTest();
		UpdateContactAddresses uca = new UpdateContactAddresses();
		Id batchId = Database.executeBatch(uca);
		Test.stopTest();


		System.assertEquals(10, [SELECT count() FROM Contact WHERE MailingCity='New York']);
	}

}