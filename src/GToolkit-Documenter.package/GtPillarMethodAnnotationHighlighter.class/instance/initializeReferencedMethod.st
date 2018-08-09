private
initializeReferencedMethod
	referencedMethod := GtDocumenterUtility 
		valueOf: self constants referencedMethodParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ]