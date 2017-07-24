public with sharing class SMSTest {
	public SMSTest() {
		
	}

	public static void getSMS(){
		Http http = new Http();
		HttpRequest request = new HttpRequest();

		request.setEndpoint('http://api.tobenetworks.com/acs/');
		request.setMethod('GET');
		HttpResponse response = http.send(request);

		if(response.getStatusCode()==200){
			system.debug('result : ' + response.getBody());
		}
	}

	public static void postSMS(){
		//Http http = new Http();
		//HttpRequest request = new HttpRequest();
		//request.setMethod('POST');

		//String url = 'http://api.tobenetworks.com/sms/';

		//String cid = 'ab8f3c9281fcbea6284d1316168b944c';
		//String token = '098899b4d4d6a6163c9166ae53effd42';

		//String strBody = 'CKey=1234';
		/////url += '&AppId=ServiceName';
		//url += '&CCode=82';
		//url += '&RecvNum=01087075737';
		//url += '&SendNum=01087075737';
		//url += '&Body=Hello I\'m Salesforce! Nice to meet you';
		//url += '&Cid='+cid;
		//url += '&token='+token;
		////url += '&StatusCallBack=http://customersite.com/result/';
		
		//request.setEndpoint(url);
		//request.setBody(strBody);

		//HttpResponse response = http.send(request);

		//if(response.getStatusCode()==201){
		//	system.debug('result : ' + response.getBody());
		//}else{
		//	system.debug('result : ' + response.getStatusCode() + ', ' + response.getStatus());
		//	system.debug('result body : ' + response.getBody());
		//}
		

		String cid = 'ab8f3c9281fcbea6284d1316168b944c';
		String token = '098899b4d4d6a6163c9166ae53effd42';

		Http http = new Http();
		HttpRequest request = new HttpRequest();
		// URL
		request.setEndpoint('http://api.tobenetworks.com/sms/');

		// Set the body as a Parameter
		String smsBody = '';
		smsBody += 'CKey=1234';
		//smsBody += '&AppId=ServiceName';
		smsBody += '&CCode=82';
		smsBody += '&RecvNum=01087075737';
		smsBody += '&SendNum=01087075737';
		smsBody += '&Body=Hello world';
		smsBody += '&Cid=' + cid;
		smsBody += '&token=' + token;

		request.setBody(smsBody);

		request.setMethod('POST');

		// Send
		HttpResponse response = http.send(request);
		system.debug('result : ' + response.getBody());

		
		Dom.Document doc = new Dom.Document();
		doc.load(response.getBody());

		DOM.XMLNode xml = doc.getRootElement();

		String strJson = XmlToJson.parsing(xml);

		//JSONGenerator generator = JSON.createGenerator(true);
		//generator.writeStartObject();


		//for(DOM.XMLNode node : xml.getChildElements()){
		//	system.debug('node Name : ' + node.getName());
		//	system.debug('node Text : ' + node.getText());
		//	generator.writeStringField(node.getName(), node.getText());
		//}

		//generator.writeEndObject();
		//generator.isClosed();
		system.debug('json : ' + strJson);
		//String json = generator.getAsString();
		//system.debug('json : ' + json);
		
		//Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(xml.getText());
		//system.debug('jsonMap key : ' + jsonMap.keySet());
	}
}