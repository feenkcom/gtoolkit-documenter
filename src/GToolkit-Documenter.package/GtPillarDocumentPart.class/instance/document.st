accessing
document
	<return: #GtDocument>
	self
		assert: [ document notNil ]
		description: [ 'Document has to be initialized first' ].
	^ document