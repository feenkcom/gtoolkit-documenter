"
I am used by ${class:Gt2DocumentExamples}$.
"
Class {
	#name : #GtDocumentExamplesUtility,
	#superclass : #Object,
	#traits : 'TGt2DocumentConstants + TBlDebug',
	#classTraits : 'TGt2DocumentConstants classTrait + TBlDebug classTrait',
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #accessing }
GtDocumentExamplesUtility class >> constants [
	^ GtDocumentConstants
]

{ #category : #'api - text' }
GtDocumentExamplesUtility class >> deleteText: aBlRope from: aFromIndex to: aToIndex [ 
	aBlRope delete: aFromIndex to: aToIndex
]

{ #category : #'api - text' }
GtDocumentExamplesUtility class >> insertText: anInsertingBlRope at: anIndex in: anEditedBlRope [ 
	anEditedBlRope insertText: anInsertingBlRope at: anIndex
]

{ #category : #accessing }
GtDocumentExamplesUtility >> constants [
	^ GtDocumentConstants
]
