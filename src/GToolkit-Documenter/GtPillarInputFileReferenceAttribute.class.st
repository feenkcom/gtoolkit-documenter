Class {
	#name : #GtPillarInputFileReferenceAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtPillarInputFileReferenceAttribute >> affect: aBrText in: anEditorElement [
	^ BlElement new 
		look: GtPillarExpandedPreviewLook;
		constraintsDo: [ :c |
			c textFlow pushLine.
			c horizontal matchParent.
			c vertical exact: 300 ];
		addChild: (GtDocumenter editorForPillar: self fileReference)
]

{ #category : #accessing }
GtPillarInputFileReferenceAttribute >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtPillarInputFileReferenceAttribute >> fileReference: aFileReference [
	fileReference := aFileReference
]
