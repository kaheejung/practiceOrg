public with sharing class Insertion_Sort {
	public Insertion_Sort() {
		
	}

	public List<Integer> doInsertionSort(List<Integer> numbers){
		for(Integer i = 1; i < numbers.size(); i++){
			// 0 1 2 3 4
			system.debug('>>>>>> numbers before : ' + numbers);
			for(Integer j = 0; j < i; j++){
				if(numbers[j] > numbers[i]){
					for(Integer k = i; k > j; k--){
						Integer temp = numbers[k];
						numbers[k] = numbers[k-1];
						numbers[k-1] = temp;
						system.debug('numbers change : ' + numbers);
					}
					j = i;
				}

				//system.debug('numbers change : ' + numbers);
			}	

			/*for(Integer j = 0; j < i; j++){
				if(numbers[j] > numbers[i]){
					Integer temp = numbers[j];
					numbers[j] = numbers[i];
					numbers[i] = temp;
				}

				system.debug('numbers change : ' + numbers);
			}*/

			system.debug('>>>>>> numbers after : ' + numbers);
			system.debug('--------------------------------------------------------');
		}

		return numbers;
	}
	// 0 1 2 3 4 5
	// 5 2 4 6 1 3
	// [2] 5 4 6 1 3 => [0] > [1]
	// 2 [4] 5 6 1 3 => [1] > [2]
	// 2 4 5 [6] 1 3 => [2] < [3]
	// [1] 2 4 5 6 3 => [0] > [4]
	// 1 2 [3] 4 5 6 => [2] > [5]
	 
	
	// i = 1, j = 0 -> 2, 5 change 2, 5, 4, 6, 1, 3
	// i = 2, j = 1 -> 4, 5 change 2, 4, 5, 6, 1, 3
	// i = 3, j = 2 -> 6, 5 false
	// i = 4, j = 0 -> 1, 5 change ...
}