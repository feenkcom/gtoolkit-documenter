private
maySetHeightOfPreview: exampleElement
	self documentPart isPreviewHeightDefined
		ifTrue: [ exampleElement previewHeight: self documentPart previewHeight ]