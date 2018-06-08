instance creation
newPreviewAttributeForExample: aGtPillarDocumentPart
	self flag: 'Use elementBlockWithErrorCatching: later'.
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlock: [ :aBrText :aTextElement | 
			((GtDocumenterPillarExampleStencilBuilder new 
				asStencilBuilder: GtPillarBrickStencilBuilder)
					documentPart: aGtPillarDocumentPart;
					text: aBrText;
					editor: aTextElement) asElement ]