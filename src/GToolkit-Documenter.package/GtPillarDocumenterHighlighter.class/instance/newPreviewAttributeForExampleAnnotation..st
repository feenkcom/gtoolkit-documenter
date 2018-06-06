instance creation
newPreviewAttributeForExampleAnnotation: aGtPillarExampleAnnotation
	^ BrTextAdornmentDynamicAttribute new
		beAppend;
		elementBlockWithErrorCatching: [ :aBrText :aTextElement | 
			((GtDocumenterPillarExampleAnnotationStencilBuilder new 
				asStencilBuilder: GtPillarBrickStencilBuilder)
					annotation: aGtPillarExampleAnnotation;
					text: aBrText;
					editor: aTextElement) asElement ]