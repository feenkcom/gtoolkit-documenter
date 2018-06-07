accessing
annotation
	<return: #GtPillarExampleAnnotation>
	self
		assert: [ annotation notNil ]
		description: [ 'Annotation should be initialized first' ].
	^ annotation