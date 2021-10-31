Class {
	#name : #GtStyleWithoutInteractionsStrategy,
	#superclass : #GtStylerStrategy,
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : #testing }
GtStyleWithoutInteractionsStrategy >> isNoInteractions [
	^ true
]

{ #category : #dispatch }
GtStyleWithoutInteractionsStrategy >> styleText: aBlRope withNode: aPRDocumentItem [
	aPRDocumentItem styleTextWithoutInteractions: aBlRope
]
