Class {
	#name : #GtStyleWithoutMarkupStrategy,
	#superclass : #GtStylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #testing }
GtStyleWithoutMarkupStrategy >> isReading [
	^ true
]

{ #category : #dispatch }
GtStyleWithoutMarkupStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithoutMarkup: aBlRope
]
