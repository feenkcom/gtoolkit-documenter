Class {
	#name : #GtStyleWithMarkupStrategy,
	#superclass : #GtStylerStrategy,
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #testing }
GtStyleWithMarkupStrategy >> isEditing [
	^ true
]

{ #category : #dispatch }
GtStyleWithMarkupStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithMarkup: aBlRope
]
