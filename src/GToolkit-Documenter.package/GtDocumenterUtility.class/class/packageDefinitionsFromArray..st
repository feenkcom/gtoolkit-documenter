pillar - parsing parameter values
packageDefinitionsFromArray: aCollection 
	<return: #Array of: #RGPackage>
	self 
		assert: [ aCollection notNil ]
		description: [ 'Package definitions has to be a collection' ].
	^ Array streamContents: [ :aStream |
			aCollection do: [ :eachPackageName | 
				| aClassDef |
				aClassDef := GtSystemUtility packageDefinitionFromString: eachPackageName asString.
				aStream nextPut: aClassDef.
		] ].