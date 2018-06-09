accessing
document: aGtDocument
	document ifNotNil: [ :anOldDocument | self unsubscribeFromDocument: anOldDocument ].
	super document: aGtDocument.
	outBindings bindings: aGtDocument globalBindings.
	aGtDocument addCodeSnippet: self.
	self subscribeToDocument: aGtDocument