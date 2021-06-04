"
I am used by {{gtClass:GtDocumenterExamples}}.


"
Class {
	#name : #GtDocumenterExamplesUtility,
	#superclass : #Object,
	#traits : 'TGtDocumentConstants + TBlDebug',
	#classTraits : 'TGtDocumentConstants classTrait + TBlDebug classTrait',
	#category : #'GToolkit-Documenter-Examples'
}

{ #category : #accessing }
GtDocumenterExamplesUtility class >> constants [
	^ GtDocumentConstants
]

{ #category : #'api - text' }
GtDocumenterExamplesUtility class >> deleteText: aBlRope from: aFromIndex to: aToIndex [ 
	aBlRope delete: aFromIndex to: aToIndex
]

{ #category : #'api - text' }
GtDocumenterExamplesUtility class >> insertText: anInsertingBlRope at: anIndex in: anEditedBlRope [ 
	anEditedBlRope insertText: anInsertingBlRope at: anIndex
]

{ #category : #accessing }
GtDocumenterExamplesUtility >> constants [
	^ GtDocumentConstants
]
