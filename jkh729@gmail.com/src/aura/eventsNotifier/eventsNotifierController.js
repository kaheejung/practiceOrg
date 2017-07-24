({
	fireComponentEvent : function(cmp, event) {
		var parentName = cmp.get("v.parentName");
        var compEvents = cmp.getEvent("componentEventFired");
     	
        compEvents.setParams({"context" : parentName});
        compEvents.fire();
	},
    
    fireApplicationEvent : function(cmp, event){
        var parentName = cmp.get("v.parentName");
        var appEvents = $A.get("e.c:appEvent");
        
        appEvent.setParams({
            "context" : parentName
        });
        appEvent.fire();
    }
})