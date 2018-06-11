instance creation
newPreviewAttribute
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlock: [ :aBrText :aTextElement | 
			((GtPillarExampleStencilBuilder new 
				asStencilBuilder: GtPillarBrickStencilBuilder)
					documentPart: self documentPart;
					text: aBrText;
					editor: aTextElement) asElement ]