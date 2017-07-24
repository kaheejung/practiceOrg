public with sharing class AccountProcessor {
	@future
	public static void countContacts(List<Id> accountIds){
		Map<Id, Integer> mapContactsByAcc = new Map<Id, Integer>();

		List<Contact> listContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds];
		for(Contact obj : listContacts){
			Integer count = mapContactsByAcc.get(obj.AccountId);
			if(count==null){
				count = 0;
				mapContactsByAcc.put(obj.AccountId, count);
			}

			count = count + 1;
		}

		List<Account> listAccountForUpdate = new List<Account>();

		for(Id id : accountIds){
			Account acc = new Account();
			acc.Id = id;
			acc.Number_of_Contacts__c = mapContactsByAcc.get(id);

			listAccountForUpdate.add(acc);
		}

		Update listAccountForUpdate;
	}
}