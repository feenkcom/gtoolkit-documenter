accessing
showMethod: aSymbol
	self 
		assert: [ aSymbol notNil ] 
		description: [ 'Show method must be non-nil' ].
	showMethod := aSymbol asSymbol