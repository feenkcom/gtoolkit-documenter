Class {
	#name : #GtStyleWithoutMarkupStrategy,
	#superclass : #GtStylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #cleanup }
GtStyleWithoutMarkupStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
GtStyleWithoutMarkupStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtStyleWithoutMarkupStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
GtStyleWithoutMarkupStrategy >> isReading [
	^ true
]

{ #category : #dispatch }
GtStyleWithoutMarkupStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithoutMarkup: aBlRope
]
