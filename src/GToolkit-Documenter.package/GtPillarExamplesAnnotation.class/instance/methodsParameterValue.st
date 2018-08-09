accessing - parameter values
methodsParameterValue
	^ GtDocumenterUtility 
		valueOf: self constants methodsParameterName 
		in: self parameters 
		value: [ :aValue | 
			self assert: aValue isArray.
			GtDocumenterUtility methodDefinitionsFromArray: aValue ] 
		emptyValue: [ #() ]
		defaultValue: [ #() ]