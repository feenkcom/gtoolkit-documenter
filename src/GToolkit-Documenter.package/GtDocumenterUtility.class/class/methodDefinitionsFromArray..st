pillar - parsing examples method collection
methodDefinitionsFromArray: aCollection 
	<return: #Array of: #RGMethodDefinition>
	| aStep anIndex |
	self 
		assert: [ aCollection notNil ]
		description: [ 'Method definitions has to be a collection' ].
	aStep := 3.
	anIndex := 1.
	^ Array streamContents: [ :aStream |
		[ anIndex + aStep - 1 <= aCollection size ] whileTrue: [ 
			| aClass aSplitter aSelector aMethodDef |
			aClass := aCollection at: anIndex.
			aSplitter := aCollection at: anIndex + 1.
			aSelector := aCollection at: anIndex + 2.
			aMethodDef := GtSystemUtility methodDefinitionFromString: aClass asString, aSplitter asString, '#', aSelector asString.
			aStream nextPut: aMethodDef.
			anIndex := anIndex + aStep.
		] ].