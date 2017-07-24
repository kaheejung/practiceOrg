global with sharing class T_CustomCaseComment  {
	public T_CustomCaseComment () {
		
	}

	private final ApexPages.StandardController stdcontroller {get; set;}
	public T_CustomCaseComment(ApexPages.StandardController controller) {
		this.stdcontroller = stdcontroller;
	}


	@remoteAction
	global static List<CaseComment__c> getCustomCaseComment(String case_id) {
		List<CaseComment__c> result = [SELECT id, CreatedBy.name , CreatedDate, CommentBody__c FROM CaseComment__c WHERE ParentId__c = :case_id ORDER BY  createddate ASC];
		return result;
	}
}