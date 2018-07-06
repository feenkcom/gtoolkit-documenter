accessing
text
	<return: #BlText>
	self
		assert: [ text notNil ]
		description: [ 'Text should be initialized first' ].
	^ text