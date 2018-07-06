private-styles
resultPreviewAttributes
	^ {
		BrTextAdornmentDynamicAttribute new
			beAppend;
			stencil: (GtPillarCodeblockResultPreviewStencilBuilder new documentPart: self documentPart)
		}