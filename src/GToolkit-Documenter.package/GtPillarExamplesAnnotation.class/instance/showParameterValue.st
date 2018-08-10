accessing - parameter values
showParameterValue
	<return: #Symbol>
	^ GtDocumenterUtility 
		valueOf: self constants showParameterName
		in: self parameters
		value: [ :aString | aString asSymbol ]
		emptyValue: [ self constants defaultShowExamplesMethodName ]
		defaultValue: [ self constants defaultShowExamplesMethodName ]