Class {
	#name : #GtHideAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGtDocumentConstants',
	#classTraits : 'TGtDocumentConstants classTrait',
	#instVars : [
		'total',
		'results',
		'successes',
		'issues'
	],
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
GtHideAttribute >> affect: aBrText in: anEditorElement [
	| anElement |
	anElement := BlElement new size: 0@0; background: BlBackground transparent.
	^ anElement
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
