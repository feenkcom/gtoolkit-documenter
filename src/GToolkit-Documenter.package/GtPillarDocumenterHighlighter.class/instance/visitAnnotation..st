visiting
visitAnnotation: anAnnotation
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color lightGray }
		from: anAnnotation start 
		to: anAnnotation stop.
	super visitAnnotation: anAnnotation