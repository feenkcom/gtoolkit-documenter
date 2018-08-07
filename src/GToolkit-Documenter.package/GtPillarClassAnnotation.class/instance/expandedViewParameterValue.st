as yet unclassified
expandedViewParameterValue
	| aValue |
	(self hasParameter: self class expandedViewParameterName) ifFalse: [ ^ false ].
	aValue := (self parameters at: self class expandedViewParameterName).
	(aValue = true or: [ aValue = false ]) ifTrue: [ ^ aValue ].
	^ false