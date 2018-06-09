initialization
initialize
	super initialize.
	codeSnippets := GtOldCodeSnippets new.
	bindings := GtDocumentBindings new.
	bindings 
		addNamed: GtDocumenterConstants resultsVariableName 
		value: codeSnippets.
	systemChangesHandler := GtSystemChangesHandler new.