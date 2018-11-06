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

{ #category : #'as yet unclassified' }
Gt2DocumentExamplesUtility >> deleteText: aBlRopedText from: anInteger to: anInteger3 [ 
	self shouldBeImplemented.
]
