accessing
editor: aBrEditorElement
	self
		assert: [ aBrEditorElement notNil ]
		description: [ 'Editor has to be initialized' ].
	editor := aBrEditorElement