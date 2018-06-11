accessing
documentPart: aGtEpiceaChanges
	self
		assert: [ aGtEpiceaChanges notNil ] 
		description: [ 'Document part has to be initialized first' ].
	documentPart := aGtEpiceaChanges