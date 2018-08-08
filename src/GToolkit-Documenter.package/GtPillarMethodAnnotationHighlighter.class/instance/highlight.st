api - actions
highlight
	| anAttributeCreatingBlock |
	(self targetText
		from: self pillarNode start 
		to: self pillarNode stop)
			foreground: Color gray.
	self initializeReferencedMethod.
	self styleReferenceParameter.
	referencedMethod ifNil: [ ^ self ].
	anAttributeCreatingBlock := [ 
		GtPillarMethodReferenceAttribute new methodReference: referencedMethod ].
	self pillarNode expandedViewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ].