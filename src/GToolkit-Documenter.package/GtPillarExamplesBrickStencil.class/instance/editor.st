accessing
editor
	<return: #BrEditorElement>
	self
		assert: [ editor notNil ]
		description: [ 'Editor should be initialized first' ].
	^ editor