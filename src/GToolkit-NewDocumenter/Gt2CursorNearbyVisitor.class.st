Class {
	#name : #Gt2CursorNearbyVisitor,
	#superclass : #Gt2CursorActivityVisitor,
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #'visiting-document' }
Gt2CursorNearbyVisitor >> notifyCursorNearby: aPRDocumentItem [
	aPRDocumentItem cursorNearbyInText: self text
]

{ #category : #'visiting-document' }
Gt2CursorNearbyVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self notifyCursorNearby: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
Gt2CursorNearbyVisitor >> visitDocumentItem: aPRDocumentItem [
	self notifyCursorNearby: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]
