global virtual with sharing class RichTextEditor_Test {
	public RichTextEditor_Test() {}
	public RichTextEditor_Test(ApexPages.StandardController std){

	}

	public blob file { get; set;}

	@RemoteAction
	global static String upload(String edit_text){

		Blob imageblob = Blob.valueOf(edit_text);

		Document doc = new Document();
		doc.Name = 'attachment.png';
		doc.Body = Encodingutil.base64Decode(edit_text.substring(edit_text.indexOf(',') + 1));
		doc.ContentType = 'image/png';
		doc.FolderId = '0056F000006Sy5NQAS';
		insert doc;

		system.debug('doc Id : ' + doc.Id);

		return doc.id;

	}

	@RemoteAction
	global static void doSave(String edit_text, String caseId){
		CaseComment objComm = new CaseComment();
		objComm.CommentBody = edit_text;
		objComm.ParentId = caseId;

		Insert objComm;
	}
}