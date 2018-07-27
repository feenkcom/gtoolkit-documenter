initialization
initialize
	super initialize.
	documentParts := GtDocumentParts new.
	globalBindings := GtPlaygroundBindings new.
	globalBindings 
		at: GtDocumenterConstants resultsVariableName 
		put: documentParts.
	systemChangesHandler := GtSystemChangesHandler new.