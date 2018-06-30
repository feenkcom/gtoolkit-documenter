actions
browseClassFrom: anEvent
	| aClassName aClass |
	aClassName := self parameters at: #value ifAbsent: [ ^ self inform: 'Missing class name' ].
	aClass := self class environment at: aClassName ifAbsent: [ ^ self inform: 'Class does not exist' ].
	anEvent target fireEvent: (GLMBlocObjectToSelect new toSelect: aClass)