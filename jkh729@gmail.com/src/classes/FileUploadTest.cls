global class  FileUploadTest {
	private final ApexPages.StandardController stdcontroller {get; set;}
	public Id caseId {get; set;}
	public boolean isSave{get; set;}

	public FileUploadTest(ApexPages.StandardController controller) {
		this.stdcontroller = stdcontroller;

		caseId = controller.getId();

		String paramIsSave = ApexPages.currentPage().getParameters().get('isSave');
		if(paramIsSave<>null && paramIsSave=='true') isSave = true;
		else isSave = false;
	}


	@RemoteAction
	global static String caseCommentInsert(String case_id) {
		CaseComment__c ccc = new CaseComment__c();
		ccc.ParentId__c = case_id;
		ccc.CommentBody__c = ' ';
		insert ccc;

		return ccc.id;
	}

	@RemoteAction
	global static List<String> bodyImageUpload(String case_comment_id, List<String> image_list) {
		Attachment[] att_list = new List<Attachment>();
		List<String> return_id_list = new List<String>();
		String image_src = null;

		for(Integer index = 0 ; index < image_list.size() ; index++) {
			image_src = image_list.get(index);

			Attachment att = new 	Attachment();
			att.Name = case_comment_id + '.png';
			att.Body = Encodingutil.base64Decode(image_src.substring(image_src.indexOf(',') + 1));
			att.ContentType = 'image/png';
			att.ParentId = case_comment_id;

			att_list.add(att);
		}

		insert att_list;

		for(Integer index = 0 ; index < att_list.size() ; index++){
			return_id_list.add(att_list.get(index).id);
		}

		return return_id_list;
	}

	@RemoteAction
	global static void caseCommentUpdate(String case_comment_id, String case_commentBody) {
		CaseComment__c ccc = new CaseComment__c();
		ccc.Id = case_comment_id;
		ccc.CommentBody__c = case_commentBody;
		update ccc;
	}

	public pageReference refreshPage(){
		PageReference pageRef = new PageReference('/' + caseId + '?isSave=' + isSave);
		pageRef.setRedirect(true);

		return pageRef;
	}

}