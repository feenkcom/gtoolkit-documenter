Class {
	#name : #GtPillarInputFileReferenceAttribute,
	#superclass : #GtPillarPharoTextEditorAttribute,
	#instVars : [
		'fileReference'
	],
	#category : #'GToolkit-Documenter-Brick'
}

{ #category : #accessing }
GtPillarInputFileReferenceAttribute >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtPillarInputFileReferenceAttribute >> fileReference: aFileReference [
	fileReference := aFileReference
]

{ #category : #'instance creation' }
GtPillarInputFileReferenceAttribute >> newStyler [
	^ BrRBTextStyler new workspace: GtHighlightingBindingStrategy new
]

{ #category : #accessing }
GtPillarInputFileReferenceAttribute >> textEditorText [
	<return: #BlText>
	^ self classReference isDefined 
		ifTrue: [ self classReference realClass definition asRopedText ]
		ifFalse: [ self classReference definition asRopedText ]
]
