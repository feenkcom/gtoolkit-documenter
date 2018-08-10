accessing - parameter values
expandedPreviewParameterValue
	^ GtDocumenterUtility 
		booleanValueOf: self constants expandedPreviewParemeterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ 
			self doNotDisplaySourceCodeParameterValue ]