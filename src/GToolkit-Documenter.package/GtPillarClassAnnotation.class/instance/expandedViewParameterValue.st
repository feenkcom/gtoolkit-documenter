accessing - parameter values
expandedViewParameterValue
	^ GtDocumenterUtility
		booleanValueOf: self constants expandedViewParameterName 
		in: self parameters 
		emptyValue: [ false ] 
		defaultValue: [ false ]