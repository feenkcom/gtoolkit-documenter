Class {
	#name : #GtPillarFigureHighlighter,
	#superclass : #GtPillarNodeHighlighter,
	#category : #'GToolkit-Documenter-Pillar - Highlighter'
}

{ #category : #'private - accessing' }
GtPillarFigureHighlighter >> figureFileReferenceOrNil [
	"Return a figure file reference or nil if figure reference is not file"

	<return: #FileReference or: nil>
	^ GtFileUtility
		fileReferenceOfUri: self pillarNode reference 
		relativeTo: self documentDirectory
]

{ #category : #'api - actions' }
GtPillarFigureHighlighter >> highlight [
	| anAttributeCreatingBlock aFigureFileReference |
	aFigureFileReference := self figureFileReferenceOrNil.
	aFigureFileReference ifNil: [ ^ self styleTextNotFileReference ].
	aFigureFileReference exists ifFalse: [ ^ self styleTextAsNotExistingFile ].
	(aFigureFileReference binaryReadStreamDo: [ :aStream | | aPositionableReadStream |
		aPositionableReadStream := ZnPositionableReadStream on: aStream.
		ImageReadWriter gtReaderClassFromStream: aPositionableReadStream ]) 
			ifNil: [ ^ self styleTextAsUnknownFigure ].
	
	self styleTextAsDefault.
	anAttributeCreatingBlock := [ | anImageForm |
		anImageForm := aFigureFileReference binaryReadStreamDo: [ :stream | 
			ImageReadWriter formFromStream: stream ].
		GtPillarPictureAttribute new image: anImageForm ].
	self styleExpandedTextExpandAttribute: anAttributeCreatingBlock.
]

{ #category : #'private - styling' }
GtPillarFigureHighlighter >> styleTextAsDefault [
	(self targetText 
		from: self pillarNodeStart
		to: self pillarNodeStop) foreground: Color gray.
]

{ #category : #'private - styling' }
GtPillarFigureHighlighter >> styleTextAsNotExistingFile [
	(self targetText 
		from: self pillarNodeStart
		to: self pillarNodeStop) foreground: BrGlamorousColors linkWithErrorColor.
]

{ #category : #'private - styling' }
GtPillarFigureHighlighter >> styleTextAsUnknownFigure [
	(self targetText 
		from: self pillarNodeStart
		to: self pillarNodeStop) foreground: Color orange.
]

{ #category : #'private - styling' }
GtPillarFigureHighlighter >> styleTextNotFileReference [
	(self targetText 
		from: self pillarNodeStart
		to: self pillarNodeStop) foreground: BrGlamorousColors linkColor.
]
