protocol
highlight: aBrRopedText ofDocument: aGtDocument
	self 
		assert: [ aBrRopedText notNil ] 
		description: [ 'The target text should be initialized' ].
	self 
		assert: [ aGtDocument notNil ] 
		description: [ 'The document should be initialized' ].
	^ self new
		targetText: aBrRopedText;
		document: aGtDocument;
		highlight