protocol
highlight: aBrRopedText 
	self 
		assert: [ aBrRopedText notNil ] 
		description: [ 'The target text should be initialized' ].
	^ self new
		targetText: aBrRopedText;
		highlight