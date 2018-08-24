Class {
	#name : #GtPillarStyler,
	#superclass : #BrTextStyler,
	#instVars : [
		'document',
		'fileReference',
		'highlighter'
	],
	#category : 'GToolkit-Documenter-Pillar'
}

{ #category : #accessing }
GtPillarStyler >> document [
	^ document
]

{ #category : #accessing }
GtPillarStyler >> document: anObject [
	document := anObject.
	highlighter document: anObject.
]

{ #category : #accessing }
GtPillarStyler >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtPillarStyler >> fileReference: anObject [
	fileReference := anObject.
	highlighter fileReference: anObject.
]

{ #category : #initialization }
GtPillarStyler >> initialize [
	super initialize.
	highlighter := GtPillarDocumenterHighlighter new.
]

{ #category : #private }
GtPillarStyler >> privateStyle: aText [ 
	highlighter targetText: aText; highlight.
	^ aText
]
