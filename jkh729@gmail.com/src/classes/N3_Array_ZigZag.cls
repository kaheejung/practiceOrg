public with sharing class N3_Array_ZigZag {
	public N3_Array_ZigZag() {
		
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

	    for(Integer rowIdx = 0; rowIdx < intX; rowIdx++){
			Integer rowCount = rowIdx == 0? 1 : rowIdx;

			List<Integer> colList = listInt[rowIdx];
			// 행의 Index가 짝수이면, 열 증가.
			if(Math.mod(rowIdx, 2)==0){
				for(Integer colIdx = 0; colIdx <= rowCount; colIdx++){
					colList[colIdx] = intNum;
					intNum++;
				}  
			}else{
			// 행의 Index가 홀수이면, 열 감소.
				for(Integer colIdx = rowCount; colIdx >= 0; colIdx--){
					colList[colIdx] = intNum;
					intNum++;
				}
			}  

			listInt[rowIdx] = colList;

			// 행 Index가 짝수인 시점에서 다시 행이 감소하면서 값이 들어감.
			if(rowIdx<>0 && Math.mod(rowIdx, 2)==0){
				for(Integer rowIdx2 = rowIdx - 1; rowIdx2 >= 0; rowIdx2--){
					colList = listInt[rowIdx2];
					colList[rowIdx] = intNum;
					intNum++;
				}

	        // 다시 0번째에서 내려옴.. ^^..
				if(rowIdx < intX - 1){
					for(Integer rowIdx2 = 0; rowIdx2 <= rowIdx; rowIdx2++){
						colList = listInt[rowIdx2];
						colList[rowIdx + 1] = intNum;
						intNum++;
					}  
				}
		        //rowIdx = 0;
			}
    	}
		return listInt;
  	}
}