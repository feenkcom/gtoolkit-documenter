initialization
initializeReferencedClass
	referencedClass := GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility classDefinitionFromString: aValue ] 
		emptyValue: [ "do nothing" ] 
		defaultValue: [ "do nothing" ]