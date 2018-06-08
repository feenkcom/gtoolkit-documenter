accessing
pillarNode: aPRDocumentItem
	self
		assert: [ aPRDocumentItem notNil ]
		description: [ 'Pillar node has to be initialized' ].
	pillarNode := aPRDocumentItem