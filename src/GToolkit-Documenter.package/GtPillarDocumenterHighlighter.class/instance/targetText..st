accessing
targetText: aBrRopedText
	self 
		assert: [ aBrRopedText notNil ] 
		description: [ 'The target text should be initialized' ].
	targetText := aBrRopedText