accessing
documentPart
	<return: #GtEpiceaChanges>
	self
		assert: [ documentPart notNil ] 
		description: [ 'Document part has to be initialized first' ].
	^ documentPart