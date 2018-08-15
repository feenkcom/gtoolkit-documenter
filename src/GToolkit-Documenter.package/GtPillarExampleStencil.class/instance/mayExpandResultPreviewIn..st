private
mayExpandResultPreviewIn: exampleElement
	self documentPart doNotDisplaySourceCodeParameterValue ifTrue: [ ^ self ].
	self documentPart expandedPreviewParameterValue ifTrue: [ exampleElement showPreview ]