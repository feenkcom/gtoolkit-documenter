instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlock: [ :aBrText :aTextElement | 
			((GtDocumenterPillarExampleStencilBuilder new 
				asStencilBuilder: GtPillarBrickStencilBuilder)
					documentPart: self documentPart;
					text: aBrText;
					editor: aTextElement) asElement ]