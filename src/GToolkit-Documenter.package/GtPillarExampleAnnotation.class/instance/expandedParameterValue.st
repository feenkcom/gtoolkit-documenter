accessing - parameter values
expandedParameterValue
	^ self 
		booleanValueOf: self class expandedParameterName
		emptyValue: [ true ]
		defaultValue: [ true ]