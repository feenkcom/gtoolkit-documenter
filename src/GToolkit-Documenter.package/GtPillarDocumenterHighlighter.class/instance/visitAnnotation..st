visiting
visitAnnotation: anAnnotation
	(self targetText 
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color gray.

	super visitAnnotation: anAnnotation