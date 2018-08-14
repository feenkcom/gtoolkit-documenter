instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: (GtPillarExampleStencilBuilder new documentPart: self pillarNode)