private
initializeReferencedMethod
	referencedMethod := GtDocumenterUtility 
		valueOf: self pillarNode class referencedClassParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ]