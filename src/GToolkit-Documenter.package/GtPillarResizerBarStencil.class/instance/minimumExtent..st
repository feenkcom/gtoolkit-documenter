accessing
minimumExtent: aPoint
	self 
		assert: [ aPoint notNil ]
		description: [ 'Minimum extent must be non-nil' ].
	minimumExtent := aPoint