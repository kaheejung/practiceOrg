global class UpdateContactAddresses  implements Database.Batchable<sObject>, Database.Stateful {
	
	global Integer recordsProcessed = 0;
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String query = 'SELECT Id, BillingStreet, BillingCity, BillingState';
		query += ', BillingPostalCode, (SELECT Id, MailingStreet, MailingCity';
		query += ', MailingState, MailingPostalCode FROM Contacts) FROM Account';
		query += ' WHERE BillingCountry = \'USA\'';

		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Account> scope) {
		List<Contact> contacts = new List<Contact>();
		for(Account account : scope){
			for(Contact contact : account.contacts){
				contact.MailingStreet = account.BillingStreet;
				contact.MailingCity = account.BillingCity;
				contact.MailingState = account.BillingState;
				contact.MailingPostalCode = account.BillingPostalCode;

				contacts.add(contact);
				recordsProcessed = recordsProcessed + 1;
			}
		}

		Update contacts;
	}
	
	global void finish(Database.BatchableContext BC) {
		System.debug(recordsProcessed + ' records processed. Shazam!')	;
		AsyncApexJob job = [
			SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email 
			FROM AsyncApexJob 
			WHERE Id = :bc.getJobId()
		];


	}
	
}