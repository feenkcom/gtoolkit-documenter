api - actions
highlight
	| anAttributeCreatingBlock |
	(self targetText
		from: self pillarNode start 
		to: self pillarNode stop)
			foreground: Color gray.
	self styleReferenceParameter.
	referencedClass ifNil: [ ^ self ].
	anAttributeCreatingBlock := [ 
		GtPillarClassReferenceAttribute new classReference: referencedClass ].
	self pillarNode expandedViewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ].