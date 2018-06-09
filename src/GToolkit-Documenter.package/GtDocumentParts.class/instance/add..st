adding
add: aGtPillarDocumentExecutablePart 
	self 
		assert: [ aGtPillarDocumentExecutablePart notNil ] 
		description: [ 'Code snippet binding cannot be nil' ].
	collection add: aGtPillarDocumentExecutablePart