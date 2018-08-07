accessing - parameter values
expandedPreviewParameterValue
	^ GtDocumenterUtility 
		booleanValueOf: self class expandedPreviewParemeterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ false ]