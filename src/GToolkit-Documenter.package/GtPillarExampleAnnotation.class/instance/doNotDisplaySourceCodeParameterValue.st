accessing - parameter values
doNotDisplaySourceCodeParameterValue
	<return: #Symbol>
	^ GtDocumenterUtility 
		booleanValueOf: self constants doNotDisplaySourceCodeParameterName
		in: self parameters
		emptyValue: [ true ]
		defaultValue: [ false ]