({
	myAction : function(component, event, helper) {
		
	},
    
    createF_CodeProject : function(cmp){
        var action = cmp.get("c.createF_CodeProject");
        
        action.setParams({
            inputCode : cmp.get("v.inputCode"),
            inputName : cmp.get("v.inputName")
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state=='SUCCESS'){
                
            }
        });
        
        $A.enqueueAction(action);
    },
    
    doSearch : function(cmp, event){
        var action = cmp.get("c.getF_CodeProjectList");
        
       //alert('Code : ' + cmp.get("v.searchCode"));
        
        
        action.setParams({
            searchCode : cmp.get("v.searchCode"),
            searchName : cmp.get("v.searchName")
        });
        
        action.setCallback(this, function(response){
        	var state = response.getState();
            if(state=='SUCCESS'){
               cmp.set("v.F_CodeProjectList", response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    },
    
    showModal : function(component, event, helper){
        document.getElementById("newClientSectionId").style.display = "block";
    },
    
    hideModal : function(component, event, helper){
        document.getElementById("newClientSectionId").style.display = "none";
    }
})