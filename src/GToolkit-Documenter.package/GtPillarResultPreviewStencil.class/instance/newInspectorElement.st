instance creation
newInspectorElement
	^ (GtPillarInspectorStencil new 
			inspect: self result;
			showMethod: self showMethod) asElement