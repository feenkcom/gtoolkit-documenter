accessing - parameter values
expandedPreviewParameterValue
	^ self 
		booleanValueOf: self class expandedPreviewParemeterName
		emptyValue: [ true ]
		defaultValue: [ false ]