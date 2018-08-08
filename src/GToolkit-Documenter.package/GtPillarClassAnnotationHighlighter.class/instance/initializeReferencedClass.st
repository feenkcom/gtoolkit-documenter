initialization
initializeReferencedClass
	referencedClass := GtDocumenterUtility 
		valueOf: self pillarNode class referencedClassParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility classDefinitionFromString: aValue ] 
		emptyValue: [ "do nothing" ] 
		defaultValue: [ "do nothing" ]