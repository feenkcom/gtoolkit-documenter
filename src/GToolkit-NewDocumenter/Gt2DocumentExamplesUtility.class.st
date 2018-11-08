Class {
	#name : #Gt2DocumentExamplesUtility,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants + TBlDebug',
	#classTraits : 'TGt2DocumentConstants classTrait + TBlDebug classTrait',
	#category : #'GToolkit-NewDocumenter-Examples'
}

{ #category : #'api - text' }
Gt2DocumentExamplesUtility class >> deleteText: aBlRope from: aFromIndex to: aToIndex [ 
	aBlRope delete: aFromIndex to: aToIndex
]

{ #category : #'api - text' }
Gt2DocumentExamplesUtility class >> insertText: anInsertingBlRope at: anIndex in: anEditedBlRope [ 
	anEditedBlRope insertText: anInsertingBlRope at: anIndex
]
