accessing
documentPartClass: aClass
	self 
		assert: [ aClass notNil ] 
		description: [ 'Document part class has to be initialized' ].
	self 
		assert: [ aClass isClass ] 
		description: [ 'Document part class has to be a lass that instantiates objects' ].
	documentPartClass := aClass