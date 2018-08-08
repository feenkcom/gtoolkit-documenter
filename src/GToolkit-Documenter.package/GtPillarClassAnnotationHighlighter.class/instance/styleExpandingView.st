private - styling
styleExpandingView
	| anAttributeCreatingBlock |
	self isClassDefined ifFalse: [ ^ self ].
	anAttributeCreatingBlock := [ GtPillarClassReferenceAttribute new
		classReference: referencedClass ].
	self pillarNode expandedViewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ]