Class {
	#name : #GtCursorNearbyVisitor,
	#superclass : #GtCursorActivityVisitor,
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #'visiting-document' }
GtCursorNearbyVisitor >> notifyCursorNearby: aPRDocumentItem [
	aPRDocumentItem cursorNearbyInText: self text
]

{ #category : #'visiting-document' }
GtCursorNearbyVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self notifyCursorNearby: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
GtCursorNearbyVisitor >> visitDocumentItem: aPRDocumentItem [
	self notifyCursorNearby: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]
