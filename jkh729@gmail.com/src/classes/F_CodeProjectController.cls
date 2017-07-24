public class F_CodeProjectController {
    @AuraEnabled
    public static void doSearch(String searchCode, String searchName){
        SearchF_Code.Code__c = searchCode;
        SearchF_Code.Name = searchName;
    }
    
    @AuraEnabled
    public static F_Code__c SearchF_Code{
        get{
            if(SearchF_Code==null) SearchF_Code = new F_Code__c();
            return SearchF_Code;
        }
        set;
    }
    
    @AuraEnabled
    public static List<F_Code__c> getF_CodeProjectList(String searchCode, String searchName){
        String strQuery = 'SELECT Id, Name, Code__c';
        strQuery += ' FROM F_Code__c';
        strQuery += ' WHERE Type__c = \'프로젝트\'';
        system.debug('searchCode : ' + searchCode);
        if(searchCode<>null && searchCode<>'') strQuery += ' AND Code__c = \'' + searchCode + '\'';
        if(searchName<>null && searchName<>'') strQuery += ' AND Name = \'' + searchName + '\'';
        
		List<F_Code__c> resultList = Database.query(strQuery);
        if(resultList.isEmpty()) resultList = new List<F_Code__c>();
        
        return resultList;
    }
    
    @AuraEnabled
    public static void createF_CodeProject(F_Code__c objF_Code){
        savepoint sp = Database.setSavePoint();
        try{
            insert objF_Code;
        }catch(Exception e){
            Database.rollback(sp);
        }
    }
}