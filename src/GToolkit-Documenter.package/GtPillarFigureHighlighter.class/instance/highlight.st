api - actions
highlight
	| anExpandingAttribute aPreviewAttribute anAttributeCreatingBlock aFigureFileReference |
	aFigureFileReference := self figureFileReferenceOrNil.
	aFigureFileReference ifNil: [ ^ self styleTextNotFileReference ].
	aFigureFileReference exists ifFalse: [ ^ self styleTextAsNotExistingFile ].
	(aFigureFileReference binaryReadStreamDo: [ :aStream | 
		ImageReadWriter gtReaderClassFromStream: aStream ]) 
			ifNil: [ ^ self styleTextAsUnknownFigure ].
	
	anAttributeCreatingBlock := [ | anImageForm |
		anImageForm := aFigureFileReference binaryReadStreamDo: [ :stream | 
			ImageReadWriter formFromStream: stream ].
		GtPillarPictureAttribute new image: anImageForm ].
	anExpandingAttribute := BrTextExpandButtonAttribute new
		attributesCreatingBlock: anAttributeCreatingBlock.
	aPreviewAttribute := anAttributeCreatingBlock value.
	anExpandingAttribute isExpanded: true.
	anExpandingAttribute createdAttributes: { aPreviewAttribute }.
	self styleTextAsDefault.
	self targetText 
		attributes: { anExpandingAttribute . aPreviewAttribute }
		from: self pillarNodeStop
		to: self pillarNodeStop