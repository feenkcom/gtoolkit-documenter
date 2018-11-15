Class {
	#name : #Gt2HideAttribute,
	#superclass : #BrTextAdornmentAttribute,
	#traits : 'TGt2DocumentConstants',
	#classTraits : 'TGt2DocumentConstants classTrait',
	#instVars : [
		'total',
		'results',
		'successes',
		'issues'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-NewDocumenter-Text - Attributes'
}

{ #category : #cleanup }
Gt2HideAttribute class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
Gt2HideAttribute class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
Gt2HideAttribute class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
Gt2HideAttribute >> affect: aBrText in: anEditorElement [
	| anElement |
	anElement := BlElement new size: 0@0; background: BlBackground transparent.
	^ anElement
]

{ #category : #initialization }
Gt2HideAttribute >> initialize [
	super initialize.
	self beReplace
]
