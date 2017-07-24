public with sharing class MacroTest {
	public MacroTest() {
		
	}

	public Id MacroId{
		get{
			if(MacroId==null){
				List<Macro> objMacro = [SELECT Id, Name FROM Macro ORDER BY Name LIMIT 1];
				if(!objMacro.isEmpty()) MacroId = objMacro[0].Id;
			}
			return MacroId;
		}
		set;
	}
}