accessing - parameters
fileParameterValue
	<return: #FileReference or: nil>
	^ self 
		valueOf: self class defaultParameterName
		value: [ :aString | aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]