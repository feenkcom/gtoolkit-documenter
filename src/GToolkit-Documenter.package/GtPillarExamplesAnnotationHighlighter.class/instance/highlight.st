api - actions
highlight
	self stylePillarNodeText.
	self pillarNode methodsParameterValue ifEmpty: [ ^ self ].
	self styleExpandedTextExpandAttribute: [ | aGroup |
		aGroup := self pillarNode exampleGroup.
		BrTextAdornmentDynamicAttribute new
			beAppend;
			stencil: (GtPillarResultPreviewStencil new
				result: aGroup ;
				outputInformation: aGroup size asString , ' examples')  ]