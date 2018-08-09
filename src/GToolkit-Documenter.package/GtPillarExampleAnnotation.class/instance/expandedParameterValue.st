accessing - parameter values
expandedParameterValue
	^ GtDocumenterUtility 
		booleanValueOf: self constants expandedViewParameterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ true ]