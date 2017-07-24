global class LeadProcessor implements Database.Batchable<sObject> {
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		String query = 'SELECT Id, LeadSource';
		query += ' FROM Lead';

		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Lead> scope) {
   		List<Lead> leads = new List<Lead>();
		for(Lead lead : scope){
			lead.LeadSource = 'Dreamforce';
			leads.add(lead);
		}

		Update leads;
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}