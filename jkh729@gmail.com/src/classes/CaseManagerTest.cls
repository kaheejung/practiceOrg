@isTest
private class CaseManagerTest {
	
	@isTest static void testGetCaseById() {
		// Implement test code
		Id recordId = createTestRecord();
		RestRequest request = new RestRequest();
		request.requestUri = 'https://kahee-test-dev-ed.my.salesforce.com/services/apexrest/Cases/' + recordId;
		request.httpMethod = 'GET';
		RestContext.request = request;

		Case thisCase = CaseManager.getCaseById();
		System.assert(thisCase != null);
		System.assertEquals('Test record', thisCase.Subject);
	}

	@isTest static void testCreateCase(){
		ID thisCaseId = CaseManager.createCase('Ferocious chipmunk', 'New', 'Phone', 'Low');
		System.assert(thisCaseId != null);
		Case thisCase = [SELECT Id, Subject FROM Case WHERE Id=:thisCaseId];
		System.assert(thisCase != null);
		System.assertEquals(thisCase.Subject, 'Ferocious chipmunk');
	}

	@isTest static void testDeleteCase(){
		Id recordId = createTestRecord();
		RestRequest request = new RestRequest();
		request.requestUri = 'https://kahee-test-dev-ed.my.salesforce.com/services/apexrest/Cases/' + recordId;
		request.httpMethod = 'GET';
		RestContext.request = request;
		CaseManager.deleteCase();

		List<Case> cases = [SELECT Id FROM Case WHERE Id = :recordId];
		System.assert(cases.size()==0);
	}
	
	@isTest static void testUpdateCaseFields(){
		Id recordId = createTestRecord();
		RestRequest request = new RestRequest();
		request.requestUri = 'https://kahee-test-dev-ed.my.salesforce.com/services/apexrest/Cases/' + recordId;
		request.httpMethod = 'GET';
		request.addHeader('Content-Type', 'application/json');
		request.requestBody = Blob.valueOf('{"status":"Working"}');
		RestContext.request = request;

		Id thisCaseId = CaseManager.updateCaseFields();

		Case thisCase = [SELECT Id, Status FROM Case WHERE Id = :thisCaseId];
		System.assert(thisCase != null);
		System.assertEquals(thisCase.Status, 'Working');

	}

	static Id createTestRecord(){
		Case caseTest = new Case(
			Subject='Test record',
			Status='New',
			Origin='Phone',
			Priority='Medium');

		Insert caseTest;
		return caseTest.Id;
	}
}