public with sharing class CaseClosedCount {
	public Integer closedCaseCount {get; set;}

	public CaseClosedCount() {
		Id userId = UserInfo.getUserId();

		List<AggregateResult> closedCount = [
			SELECT COUNT(Id) cnt FROM Case
			WHERE OwnerId = :userId AND Status = 'Closed'
			AND ClosedDate = TODAY
		];

		if(!closedCount.isEmpty()) closedCaseCount = Integer.valueOf(closedCount[0].get('cnt'));
		else closedCaseCount = 0;
	}
}