accessing
text
	<return: #BrText>
	self
		assert: [ text notNil ]
		description: [ 'Text should be initialized first' ].
	^ text