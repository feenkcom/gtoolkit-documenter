accessing
exampleGroup
	^ GtExampleGroup new examples: (self methodsParameterValue flatCollect: [ :eachMethodDef | 
			eachMethodDef isValid ifTrue: [ eachMethodDef compiledMethod gtExamples ] ifFalse: [ #() ] ])