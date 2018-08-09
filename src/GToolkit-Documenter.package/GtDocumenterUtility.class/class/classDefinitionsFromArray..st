pillar - parsing parameter values
classDefinitionsFromArray: aCollection 
	<return: #Array of: #RGClassDefinition>
	self 
		assert: [ aCollection notNil ]
		description: [ 'Class definitions has to be a collection' ].
	^ Array streamContents: [ :aStream |
			aCollection do: [ :eachClassName | 
				| aClassDef |
				aClassDef := GtSystemUtility classDefinitionFromString: eachClassName asString.
				aStream nextPut: aClassDef.
		] ].