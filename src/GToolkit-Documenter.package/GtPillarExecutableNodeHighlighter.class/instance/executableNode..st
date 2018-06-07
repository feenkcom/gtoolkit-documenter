accessing
executableNode: aGtPillarExecutableNode
	self
		assert: [ aGtPillarExecutableNode notNil ] 
		description: [ 'Executable node has to be initialized' ].
	executableNode := aGtPillarExecutableNode