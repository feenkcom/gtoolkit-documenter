converting
asDictionary
	<return: #Dictionary>
	| aDictionary anOutBindings |
	aDictionary := self bindings asDictionary.
	anOutBindings := self previousCodeSnippetResult.
	anOutBindings ifNotNil: [ 
		aDictionary 
			at: GtDocumenterConstants resultVariableName
			put: anOutBindings ].
	^ aDictionary