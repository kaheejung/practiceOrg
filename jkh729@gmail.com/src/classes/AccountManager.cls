@RestResource(urlMapping='/Account/*')
global with sharing class AccountManager {
	@HttpGet
	global static Account getAccount() {
		system.debug('test 2222222');
		system.debug('automatic sync?!');
		system.debug('Change AccountManager Class');
		RestRequest request = RestContext.request;
		String thisAccId = request.requestURI.substring(request.requestURI.lastIndexOf('/') - 18);
		thisAccId = thisAccId.split('/')[0];

		List<Contact> contactByAccount = [SELECT Id, Name FROM Contact WHERE AccountId = :thisAccId];
		system.debug('AccountId : ' + thisAccId);
		Account thisAccount = [SELECT Id, Name FROM Account WHERE Id =: thisAccId];
		
		//system.debug('thisAccount : ' + thisAccount);
		return thisAccount;

	}
}