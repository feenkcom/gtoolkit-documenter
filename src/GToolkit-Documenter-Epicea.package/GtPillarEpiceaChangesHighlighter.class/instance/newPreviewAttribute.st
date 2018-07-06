instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		stencil: (GtPillarEpiceaBrickStencilBuilder new documentPart: self documentPart)