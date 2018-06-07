instance creation
newPreviewAttributeForExampleAnnotation: aGtPillarExecutableNode
	self flag: 'Use elementBlockWithErrorCatching: later'.
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlock: [ :aBrText :aTextElement | 
			((GtDocumenterPillarExampleAnnotationStencilBuilder new 
				asStencilBuilder: GtPillarBrickStencilBuilder)
					annotation: aGtPillarExecutableNode;
					text: aBrText;
					editor: aTextElement) asElement ]