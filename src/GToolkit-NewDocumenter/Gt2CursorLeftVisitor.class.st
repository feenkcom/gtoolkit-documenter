Class {
	#name : #Gt2CursorLeftVisitor,
	#superclass : #Gt2CursorActivityVisitor,
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #'visiting-document' }
Gt2CursorLeftVisitor >> notifyCursorLeft: aPRDocumentItem [
	aPRDocumentItem cursorLeftInText: self text
]

{ #category : #'visiting-document' }
Gt2CursorLeftVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self notifyCursorLeft: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
Gt2CursorLeftVisitor >> visitDocumentItem: aPRDocumentItem [
	self notifyCursorLeft: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]
