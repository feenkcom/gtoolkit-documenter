Class {
	#name : #Gt2CursorNearByVisitor,
	#superclass : #Gt2CursorActivityVisitor,
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #'visiting-document' }
Gt2CursorNearByVisitor >> notifyCursorNearBy: aPRDocumentItem [
	aPRDocumentItem cursorNearByInText: self text
]

{ #category : #'visiting-document' }
Gt2CursorNearByVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self notifyCursorNearBy: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
Gt2CursorNearByVisitor >> visitDocumentItem: aPRDocumentItem [
	self notifyCursorNearBy: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]
