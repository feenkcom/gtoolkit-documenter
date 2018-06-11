instance creation
newPreviewAttribute
	self flag: 'use elementBlockWithErrorCatching: instead of elementBlock:'.
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlock: [ :aBrText :aTextElement | 
			(GtPillarEpiceaBrickStencilBuilder new
				text: aBrText;
				editor: aTextElement;
				documentPart: self documentPart) asElement ]