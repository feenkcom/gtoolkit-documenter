accessing - parameter values
methodDefinition
	<return: #RGMethodDefinition or: nil>
	"Return Ring method definition from a string method definition, e.g., MyClass>>#myMethod"
	^ GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self parameters
		value: [ :aString | GtSystemUtility methodDefinitionFromString: aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]