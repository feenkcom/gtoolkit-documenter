actions
browseMethodFrom: anEvent
	| aMethodName aMethod |
	aMethodName := GtDocumenterUtility 
		valueOf: self constants referencedMethodParameterName 
		in: self parameters 
		value: [ :aValue | aValue ] 
		emptyValue: [ ^ self inform: 'Missing method name' ] 
		defaultValue: [ ^ self inform: 'Missing method name' ].
	aMethod := GtSystemUtility methodDefinitionFromString: aMethodName.
	aMethod isDefined ifFalse: [ ^ self inform: 'Method is not defined' ].
	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: aMethod)