@isTest
global class AnimalLocatorMock implements HttpCalloutMock{
	
	global HTTPResponse respond(HttpRequest request){
		HttpResponse response = new HttpResponse();
		response.setHeader('Content-Type', 'application/json');
		
		response.setBody('{"animal": {"eats":"berries", "id":"2", "name":"bear", "says":"yum yum"}}');
		response.setStatusCode(200);

		return response;
	}
	
}