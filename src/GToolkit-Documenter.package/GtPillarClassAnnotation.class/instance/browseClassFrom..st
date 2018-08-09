actions
browseClassFrom: anEvent
	| aClassName aClass |
	aClassName := GtDocumenterUtility 
		valueOf: self constants nameParameterName 
		in: self parameters 
		value: [ :aValue | aValue asSymbol ] 
		emptyValue: [ ^ self inform: 'Missing class name' ] 
		defaultValue: [ ^ self inform: 'Missing class name' ].
	aClass := self class environment at: aClassName ifAbsent: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: aClass)