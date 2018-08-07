private - styling
styleCollapsedTextExpandAttribute: anAttributeCreatingBlock
	| anExpandingAttribute |
	anExpandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: anAttributeCreatingBlock.
	self targetText 
		attributes: { anExpandingAttribute }
		from: self pillarNodeStop
		to: self pillarNodeStop