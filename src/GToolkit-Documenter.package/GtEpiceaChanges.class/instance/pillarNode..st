accessing
pillarNode: aPRDocumentItem
	super pillarNode: aPRDocumentItem.
	self assert: [ epiceaLog isNil ] description: [ 'Epicea log should be initialized just once' ].
	epiceaLog := GtEpiceaLog fromFileReference: self changeFileReference.
	epiceaLog 
		subscribe: EpEntryAdded 
		send: #handleEpEntryAddedAnnouncement: 
		to: self 
		for: self.