accessing - parameter values
expandedViewParameterValue
	^ GtDocumenterUtility
		booleanValueOf: self expandedViewParameterName 
		in: self parameters 
		emptyValue: [ false ] 
		defaultValue: [ false ]