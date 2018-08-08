private - styling
styleExpandingView
	| anAttributeCreatingBlock |
	self isMethodDefined ifFalse: [ ^ self ].
	anAttributeCreatingBlock := [ GtPillarMethodReferenceAttribute new
		methodReference: referencedMethod ].
	self pillarNode expandedViewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ]