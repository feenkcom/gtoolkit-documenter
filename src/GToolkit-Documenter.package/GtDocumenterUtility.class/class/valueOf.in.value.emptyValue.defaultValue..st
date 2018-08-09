pillar - parameter values
valueOf: aString in: aDictionary value: valueBlock emptyValue: emptyBlock defaultValue: defaultBlock
	^ aDictionary
		at: aString
		ifPresent: [ :aValue | 
			(aValue isNil or: [ aValue = '' ])
				ifTrue: [ emptyBlock cull: aValue ] 
				ifFalse: [ valueBlock cull: aValue ] ]
		ifAbsent: [ defaultBlock value ]