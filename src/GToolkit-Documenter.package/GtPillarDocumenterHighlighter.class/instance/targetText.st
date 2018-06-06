accessing
targetText
	self 
		assert: [ targetText notNil ] 
		description: [ 'The target text should be initialized before using it' ].
	^ targetText