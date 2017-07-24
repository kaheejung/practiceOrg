({
	clickAdd : function(component, event, helper) {
        var n1 = component.find("num1").get("v.value");
        var n2 = component.find("num2").get("v.value");
        
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Quick Add : " + n1 + " + " + n2,
            "message": "The total is : " + (n1 + n2) + "."
        });
        resultsToast.fire();
        
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();
	}
})