api - actions
highlight
	| anAttributeCreatingBlock aFigureFileReference |
	aFigureFileReference := self figureFileReferenceOrNil.
	aFigureFileReference ifNil: [ ^ self styleTextNotFileReference ].
	aFigureFileReference exists ifFalse: [ ^ self styleTextAsNotExistingFile ].
	(aFigureFileReference binaryReadStreamDo: [ :aStream | 
		ImageReadWriter gtReaderClassFromStream: aStream ]) 
			ifNil: [ ^ self styleTextAsUnknownFigure ].
	
	self styleTextAsDefault.
	anAttributeCreatingBlock := [ | anImageForm |
		anImageForm := aFigureFileReference binaryReadStreamDo: [ :stream | 
			ImageReadWriter formFromStream: stream ].
		GtPillarPictureAttribute new image: anImageForm ].
	self styleExpandedTextExpandAttribute: anAttributeCreatingBlock.