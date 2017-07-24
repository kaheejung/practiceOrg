public with sharing class Dashboard_Test {

	public Integer intSalesResult {get; set;} // 매출실적
	public Integer intMonthCalcGoal {get; set;} // 월누적목표
	public Integer intYearGoal {get; set;} // 연간 목표

	public Dashboard_Test() {
		intSalesResult = 0;
		intMonthCalcGoal = 0;
		intYearGoal = 0;
	}

	public void init(){
		
	}
}