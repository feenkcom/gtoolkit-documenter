accessing
text: aBrText
	self
		assert: [ aBrText notNil ]
		description: [ 'Text has to be initialized' ].
	text := aBrText