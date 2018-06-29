visiting
visitAnnotation: anAnnotation
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color gray }
		from: anAnnotation start 
		to: anAnnotation stop.
	super visitAnnotation: anAnnotation