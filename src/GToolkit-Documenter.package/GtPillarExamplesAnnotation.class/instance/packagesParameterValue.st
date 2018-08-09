accessing - parameter values
packagesParameterValue
	^ GtDocumenterUtility 
		valueOf: self constants packagesParameterName 
		in: self parameters 
		value: [ :aValue | 
			self assert: aValue isArray.
			GtDocumenterUtility packageDefinitionsFromArray: aValue ] 
		emptyValue: [ #() ]
		defaultValue: [ #() ]