private
initializeReferencedMethod
	referencedMethod := GtDocumenterUtility 
		valueOf: self constants nameParameterName
		in: self pillarNode parameters 
		value: [ :aValue | GtSystemUtility methodDefinitionFromString: aValue ] 
		emptyValue: [ nil ] 
		defaultValue: [ nil ]