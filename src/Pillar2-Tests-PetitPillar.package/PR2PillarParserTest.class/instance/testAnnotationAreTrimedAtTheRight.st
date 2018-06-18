tests - Annotation
testAnnotationAreTrimedAtTheRight
	super testAnnotationAreTrimedAtTheRight.
	self
		assert: result
		equals:
			(PRInputFileAnnotation
				withParameters:
					(OrderedDictionary new
						at: 'value' put: 'Foo';
						yourself)).
	self assertStart: 1 stop: 23.