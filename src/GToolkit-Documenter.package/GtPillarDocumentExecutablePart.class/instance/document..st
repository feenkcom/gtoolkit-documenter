accessing
document: aGtDocument
	super document: aGtDocument.
	outBindings bindings: aGtDocument globalBindings.
	aGtDocument addCodeSnippet: self.