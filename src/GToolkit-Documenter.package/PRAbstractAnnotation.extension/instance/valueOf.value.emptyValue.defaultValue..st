*GToolkit-Documenter
valueOf: aString value: valueBlock emptyValue: emptyBlock defaultValue: defaultBlock
	^ self parameters
		at: aString
		ifPresent: [ :aValue | 
			aValue isEmptyOrNil 
				ifTrue: [ emptyBlock value ]
				ifFalse: [ valueBlock cull: aValue ] ]
		ifAbsent: [ defaultBlock value ]