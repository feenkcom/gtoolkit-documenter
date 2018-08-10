accessing
stencil: aStencil
	self 
		assert: [ aStencil notNil ]
		description: [ 'Content stencil builder must be non-nil' ].
	contentStencilBuilder := aStencil asStencilBuilder