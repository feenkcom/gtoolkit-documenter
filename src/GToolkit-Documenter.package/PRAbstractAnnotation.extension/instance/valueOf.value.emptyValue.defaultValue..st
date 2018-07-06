*GToolkit-Documenter
valueOf: aString value: valueBlock emptyValue: emptyBlock defaultValue: defaultBlock
	^ self parameters
		at: aString
		ifPresent: [ :aValue | 
			valueBlock cull: aValue ]
		ifAbsent: [ defaultBlock value ]