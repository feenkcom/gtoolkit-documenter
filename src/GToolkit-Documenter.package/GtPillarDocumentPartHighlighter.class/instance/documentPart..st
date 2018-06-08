accessing
documentPart: aGtPillarExecutableNode
	self
		assert: [ aGtPillarExecutableNode notNil ] 
		description: [ 'Executable node has to be initialized' ].
	documentPart := aGtPillarExecutableNode