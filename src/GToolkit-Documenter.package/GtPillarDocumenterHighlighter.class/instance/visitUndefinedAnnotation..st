visiting
visitUndefinedAnnotation: anAnnotation
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color red }
		from: anAnnotation start 
		to: anAnnotation stop.