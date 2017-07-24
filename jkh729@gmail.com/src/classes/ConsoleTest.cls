public with sharing class ConsoleTest {
	public ConsoleTest() {
		
	}

	public ConsoleTest(ApexPages.StandardController std){

	}

	public List<CaseComment> CaseCommentList{
		get{
			if(CaseCommentList==null){
				CaseCommentList = new List<CaseComment>();

				Id caseId = ApexPages.currentPage().getParameters().get('Id');

				List<Case> cases = [
					Select Id, 
						(
							Select Id, ParentId, IsPublished, CommentBody, CreatedById, CreatedDate, CreatedBy.Name
								, SystemModstamp, LastModifiedDate, LastModifiedById, IsDeleted 
							From CaseComments
						) 
					From Case
					WHERE Id = :caseId
				];

				for(Case obj : cases){
					for(CaseComment comm : obj.CaseComments) CaseCommentList.add(comm);
				}

			}
			return CaseCommentList;
		}
		set;
	}
}