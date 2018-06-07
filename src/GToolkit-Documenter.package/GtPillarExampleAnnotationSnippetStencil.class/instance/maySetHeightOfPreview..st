private
maySetHeightOfPreview: exampleElement
	self annotation isPreviewHeightDefined
		ifTrue: [ exampleElement previewHeight: self annotation previewHeight ]