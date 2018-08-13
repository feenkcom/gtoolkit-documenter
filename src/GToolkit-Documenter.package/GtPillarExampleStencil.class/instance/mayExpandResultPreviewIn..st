private
mayExpandResultPreviewIn: exampleElement
	self documentPart shouldDisplaySourceCode ifFalse: [ ^ self ].
	self documentPart shouldExpandPreview ifTrue: [ exampleElement showPreview ]