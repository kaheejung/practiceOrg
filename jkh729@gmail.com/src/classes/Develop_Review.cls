public with sharing class Develop_Review {
	public Develop_Review() {
		
	}

	public void doSearchReview(){
		selectedLabel = null;
	}

	public String selectedValue {
		get{
			if(selectedValue==null) selectedValue = '';
			return selectedValue;
		}
		set;
	}
	public String selectedLabel {
		get{
			if(selectedLabel==null){
				selectedLabel = 'Review';
				if(selectedValue<>null && selectedValue<>''){
					for(SelectOption so : listSelectOptionReview){
						if(so.getValue()==selectedValue) selectedLabel = so.getLabel();
					}
				}
			}
			return selectedLabel;
		}
		private set;
	}
	public List<SelectOption> listSelectOptionReview{
		get{
			if(listSelectOptionReview==null){
				listSelectOptionReview = new List<SelectOption>();
				listSelectOptionReview.add(new SelectOption('', '-- None --'));
				listSelectOptionReview.add(new SelectOption('N2_Wrapper', 'No.2 - Wrapper Class(2017.04.24)'));
				listSelectOptionReview.add(new SelectOption('N3_Array_ZigZag', 'No.3 - Array ZigZag(2017.05.10)'));
				listSelectOptionReview.add(new SelectOption('N4_Array_Oblique', 'No.4 - Array Oblique(2017.05.15)'));
			}
			return listSelectOptionReview;
		}
		private set;
	}
}