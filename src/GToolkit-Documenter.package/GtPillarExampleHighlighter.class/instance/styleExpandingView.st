private-styles
styleExpandingView
	| anAttributeCreatingBlock |
	anAttributeCreatingBlock := [ self newPreviewAttribute ].
	self pillarNode expandedPreviewParameterValue
		ifTrue: [ self styleExpandedTextExpandAttribute: anAttributeCreatingBlock ]
		ifFalse: [ self styleCollapsedTextExpandAttribute: anAttributeCreatingBlock ]