Class {
	#name : #GtCursorLeftVisitor,
	#superclass : #GtCursorActivityVisitor,
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #'visiting-document' }
GtCursorLeftVisitor >> notifyCursorLeft: aPRDocumentItem [
	aPRDocumentItem cursorLeftInText: self text
]

{ #category : #'visiting-document' }
GtCursorLeftVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self notifyCursorLeft: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
GtCursorLeftVisitor >> visitDocumentItem: aPRDocumentItem [
	self notifyCursorLeft: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]
