accessing - parameter values
heightParameterValue
	^ GtDocumenterUtility 
		valueOf: self constants heightParameterName
		in: self parameters
		value: [ :aString | (NumberParser on: aString)
			failBlock: [ nil ];
			nextNumber ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]