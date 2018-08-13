accessing
documentPart
	<return: #GtPillarDocumentPart>
	self
		assert: [ documentPart notNil ]
		description: [ 'Document part should be initialized first' ].
	^ documentPart