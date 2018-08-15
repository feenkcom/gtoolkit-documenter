accessing
document: aGtDocument
	self 
		assert: [ aGtDocument notNil ]
		description: [ 'Pillar node''s document must be non-nil' ].
	^ self propertyAt: #document put: aGtDocument