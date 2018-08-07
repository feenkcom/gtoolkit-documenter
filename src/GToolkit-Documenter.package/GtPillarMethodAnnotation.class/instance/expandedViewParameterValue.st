accessing - parameter values
expandedViewParameterValue
	^ GtDocumenterUtility
		booleanValueOf: self class expandedViewParameterName 
		in: self parameters 
		emptyValue: [ false ] 
		defaultValue: [ false ]