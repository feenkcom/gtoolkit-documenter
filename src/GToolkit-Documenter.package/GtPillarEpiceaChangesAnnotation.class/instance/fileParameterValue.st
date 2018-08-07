accessing - parameters
fileParameterValue
	<return: #FileReference or: nil>
	^ GtDocumenterUtility 
		valueOf: self class defaultParameterName
		in: self parameters
		value: [ :aString | aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]