Class {
	#name : #GtStyleWithMarkupStrategy,
	#superclass : #GtStylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #cleanup }
GtStyleWithMarkupStrategy class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #cleanup }
GtStyleWithMarkupStrategy class >> resetUniqueInstance [
	uniqueInstance := nil
]

{ #category : #accessing }
GtStyleWithMarkupStrategy class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #testing }
GtStyleWithMarkupStrategy >> isEditing [
	^ true
]

{ #category : #dispatch }
GtStyleWithMarkupStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithMarkup: aBlRope
]
