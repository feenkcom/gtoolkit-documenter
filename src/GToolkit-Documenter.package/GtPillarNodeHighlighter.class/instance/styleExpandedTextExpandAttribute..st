as yet unclassified
styleExpandedTextExpandAttribute: anAttributeCreatingBlock
	| anExpandingAttribute aPreviewAttribute |
	anExpandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: anAttributeCreatingBlock.
	aPreviewAttribute := anAttributeCreatingBlock value.
	anExpandingAttribute isExpanded: true.
	anExpandingAttribute createdAttributes: { aPreviewAttribute }.
	self targetText 
		attributes: { anExpandingAttribute . aPreviewAttribute }
		from: self pillarNodeStop
		to: self pillarNodeStop