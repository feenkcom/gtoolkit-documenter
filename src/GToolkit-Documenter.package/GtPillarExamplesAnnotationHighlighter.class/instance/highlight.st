api - actions
highlight
	self stylePillarNodeText.
	self pillarNode hasExamples ifFalse: [ ^ self ].
	self styleExpandedTextExpandAttribute: [ | aGroup |
		aGroup := self pillarNode exampleGroup.
		BrTextAdornmentDynamicAttribute new
			beAppend;
			stencil: (GtPillarResultPreviewStencil new
				result: aGroup ;
				outputInformation: aGroup size asString , ' examples';
				showMethod: self pillarNode showParameterValue) ]