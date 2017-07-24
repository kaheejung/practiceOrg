@isTest
private class AccountProcessorTest {
	@isTest static void test_method_one() {
		Account acc1 = new Account();
		acc1.Name = 'Test1';
		Insert acc1;

		Contact con = new Contact();
		con.LastName = 'Test1';
		con.FirstName = 'Kim';
		con.AccountId = acc1.Id;
		Insert con;

		Contact con2 = new Contact();
		con2.LastName = 'Test2';
		con2.FirstName = 'Lee';
		con2.AccountId = acc1.Id;
		Insert con2;

		// Implement test code
		Test.startTest();
			AccountProcessor.countContacts(new List<Id>{acc1.Id});
		Test.stopTest();
	}
	
}