public class AnimalLocator {

	public static String getAnimalNameById(Integer intParam){
		String strResult = '';

		Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + intParam);
		request.setMethod('GET');
		HttpResponse response = http.send(request);

		if(response.getStatusCode() == 200){
			Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
			Map<String, Object> results2 = (Map<String, Object>)results.get('animal');
			strResult = (String)results2.get('name');
			system.debug('results : ' + results);
			system.debug('results values : ' + results.values());
			system.debug('results key : ' + results.keySet());
			//strResult = (String)results.values();
		}

		system.debug('strResult : ' + strResult);

		return strResult;
	}
}