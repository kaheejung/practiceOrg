public with sharing class N4_Array_Oblique {
	public N4_Array_Oblique() {
		
	}

	public Integer inputX {get; set;}
	public List<List<Integer>> listResults {get; set;}

	public void doDrawArray(){
		if(inputX<>null) listResults = doPrintArray(inputX);
	}

	public static List<List<Integer>> doPrintArray(Integer intX){
	    List<List<Integer>> listInt = new List<List<Integer>>();
	    Integer intNum = 1;

	    // 일단 리스트 초기화.
	    for(Integer i = 0; i < intX; i++){
			List<Integer> tempList = new List<Integer>();
			for(Integer j = 0; j < intX; j++) tempList.add(0);

			listInt.add(tempList);
	    }

	    // 총 실행되는 횟수.
	    // intX * 2 -1

	    // ex) 5 X 5
	    // (0, 0) (1, 1) (2, 2) (3, 3) (4, 4)	col = row
	    // (1, 0) (2, 1) (3, 2) (4, 3)			col = row - 1
	    // (2, 0) (3, 1) (4, 2)					col = row - 2
	    // (3, 0) (4, 1)						col = row - 3
	    // (4, 0)								col = row - 4
	    // Up!===============================
	    // (0, 4)								col = row + 4
	    // (0, 3) (1, 4)						col = row + 3
	    // (0, 2) (1, 3) (2, 4)					col = row + 2
	    // (0, 1) (1, 2) (2, 3) (3, 4)			col = row + 1

	    // Down일 경우.
	    // row는 1씩 증가, col은 row만큼 감소.
	    // Up일 경우.
	    // row는 0으로 고정, col은 증가.

	   	Integer count = intX * 2 - 1;
	   	Integer rowStartIdx = 0;
	   	Integer maxCnt = intX; // 총 채울 열 카운트.
	   	Integer intSettingCol = 0;
	   	Boolean isUp = false;

	    for(Integer cnt = 1; cnt <= count; cnt++){
	    	for(Integer rowIdx = rowStartIdx; rowIdx < maxCnt; rowIdx++){
	    		if(!isUp){
	    			listInt[rowIdx][rowIdx - intSettingCol] = intNum;
	    			
    			}else{
    				listInt[rowIdx][rowIdx + intSettingCol] = intNum;
    			}
    			intNum++;
	    	}

	    	if(maxCnt<>1 && rowStartIdx==(maxCnt-1)){
	    		isUp = true;
	    		maxCnt = 0;
	    		rowStartIdx = 0;
	    		intSettingCol = intSettingCol + 1;
	    	}

	    	if(!isUp){
	    		intSettingCol++;
	    		rowStartIdx++;
	    	}else{
	    		maxCnt++;
	    		intSettingCol--;
	    	}
	    }

		return listInt;
  	}
}