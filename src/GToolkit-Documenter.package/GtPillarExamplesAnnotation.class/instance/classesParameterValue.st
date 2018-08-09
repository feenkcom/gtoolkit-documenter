accessing - parameter values
classesParameterValue
	^ GtDocumenterUtility 
		valueOf: self constants classesParameterName 
		in: self parameters 
		value: [ :aValue | 
			self assert: aValue isArray.
			GtDocumenterUtility classDefinitionsFromArray: aValue ] 
		emptyValue: [ #() ]
		defaultValue: [ #() ]