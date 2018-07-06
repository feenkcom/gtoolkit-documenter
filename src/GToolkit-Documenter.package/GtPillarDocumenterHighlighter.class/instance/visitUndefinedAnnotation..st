visiting
visitUndefinedAnnotation: anAnnotation
	(self targetText
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color red