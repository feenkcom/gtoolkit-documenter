accessing
document: aGtDocument
	document ifNotNil: [ :anOldDocument | self unsubscribeFromDocument: anOldDocument ].
	self
		assert: [ aGtDocument notNil ]
		description: [ 'Document has to be initialized' ].
	document := aGtDocument.
	self subscribeToDocument: aGtDocument