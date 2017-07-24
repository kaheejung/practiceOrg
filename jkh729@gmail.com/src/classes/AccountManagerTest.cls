@isTest
private class AccountManagerTest {
	
	@isTest static void test_method_one() {
		Id recordId = createTestRecord();

		// Implement test code
		RestRequest request = new RestRequest();
		request.requestUri = 'https://kahee-test-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId + '/contacts';
		request.httpMethod = 'GET';
		RestContext.request = request;

		//List<Contact> getContactList = AccountManager.getAccount();
		//System.assert(getContactList != null);
		Account thisAccount = AccountManager.getAccount();
		System.assert(thisAccount != null);

	}
	
	static Id createTestRecord(){
		Account accountForInsert = new Account();
		accountForInsert.Name = 'Test Account';
		Insert accountForInsert;

		Contact contactForInsert = new Contact();
		contactForInsert.LastName = 'Test';
		contactForInsert.FirstName = 'Kim';
		contactForInsert.AccountId = accountForInsert.Id;
		Insert contactForInsert;

		return accountForInsert.Id;
	}
}