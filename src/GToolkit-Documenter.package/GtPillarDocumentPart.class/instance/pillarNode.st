accessing
pillarNode
	<return: #PRDocumentItem>
	self
		assert: [ pillarNode notNil ]
		description: [ 'Pillar node has to be initialized first' ].
	^ pillarNode