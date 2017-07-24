public with sharing class CaseCustomPage {
	public Id CaseId {get; set;}

	public CaseCustomPage() {
			
	}
	public CaseCustomPage(ApexPages.StandardController std){
		CaseId = std.getId();
	}

	public Component.Apex.Detail getDynamicDetail(){
		Component.Apex.Detail detail = new Component.Apex.Detail();
		return detail;
	}

}