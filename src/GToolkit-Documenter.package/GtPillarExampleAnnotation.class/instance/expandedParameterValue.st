accessing - parameter values
expandedParameterValue
	^ GtDocumenterUtility 
		booleanValueOf: self class expandedParameterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ true ]