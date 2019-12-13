Class {
	#name : #GtHideAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Documenter-Text - Attributes'
}

{ #category : #cleanup }
GtHideAttribute class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #accessing }
GtHideAttribute class >> constants [
	^ GtDocumentConstants
]

{ #category : #cleanup }
GtHideAttribute class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtHideAttribute class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
GtHideAttribute >> affect: aTBrTextEditorTextualPiece in: anEditorElement [
	^ #()
]

{ #category : #accessing }
GtHideAttribute >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
GtHideAttribute >> initialize [
	super initialize.
	self beReplace
]
