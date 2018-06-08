as yet unclassified
resultPreviewAttributes
	self flag: 'Use elementBlockWithErrorCatching: instead of elementBlock:'.
	^ Array with: (BrTextAdornmentDynamicAttribute new
				beAppend;
				elementBlock: [ :aBrText :aTextElement | 
					((GtPillarCodeblockResultPreviewStencilBuilder new 
						asStencilBuilder: GtPillarBrickStencilBuilder)
							text: aBrText;
							editor: aTextElement;
							documentPart: self documentPart) asElement ])