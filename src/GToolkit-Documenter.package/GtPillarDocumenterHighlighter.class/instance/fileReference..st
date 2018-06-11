accessing
fileReference: aFileReference
	self 
		assert: [ aFileReference notNil ] 
		description: [ 'The file reference should be initialized' ].
	self 
		assert: [ aFileReference exists ] 
		description: [ 'The file reference should exist' ].
	fileReference := aFileReference