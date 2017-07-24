public class XmlToJson {
	public static String strXML {get; set;}
	public static String parsedJSON {get; set;}
	public static DOM.XMLNode[] arrXMLNode {get; set;}

	public static String parsing(DOM.XMLNode xmlNode){
		system.debug('fjdsfjs');
		system.debug('fjdsfjs');
		system.debug('fjdsfjs');
		JSONGenerator generator = JSON.createGenerator(true);
		generator.writeStartObject();
		arrXMLNode = xmlNode.getChildren();

		system.debug('children size : ' + xmlNode.getChildren().size());
		//system.debug('children : ' + xmlNode.getChildren());
		system.debug('ChildElements size : ' + xmlNode.getChildElements().size());
		system.debug('xmlNode getAttributeCount() : ' +  xmlNode.getAttributeCount());
        
		for(DOM.XMLNode node : xmlNode.getChildElements()){
			String fieldName = '';
			String value = '';

			system.debug('node Name : ' + node.getName() + ', node size : ' + node.getChildren().size());
			if(node.getChildren().size()>1){
                system.debug('node getAttributeCount() : ' + node.getAttributeCount());
				Integer idx = node.getChildren().size() - 2;
				DOM.XmlNode[] arrChildNode = node.getChildren();
				system.debug('child Name : ' + arrChildNode[idx].getName() + ', child text : ' + arrChildNode[idx].getText());
               	//system.debug('arrChildNode getAttributeCount() : ' + arrChildNode[idx].getAttributeCount());
				
				fieldName = arrChildNode[idx].getName();
				value = arrChildNode[idx].getText();

				//system.debug('child > child size : ' + arrChildNode[idx].getChildren().size());
			}else{
				fieldName = node.getName();
				value = node.getText();
			}
			generator.writeStringField(fieldName, value);
		}

		generator.writeEndObject();
		generator.close();

		return generator.getAsString();
	}

	public void send(){
		DOM.Document doc = new DOM.Document();
		doc.load(strXML);

		parsedJSON = parsing(doc.getRootElement());
	}
}