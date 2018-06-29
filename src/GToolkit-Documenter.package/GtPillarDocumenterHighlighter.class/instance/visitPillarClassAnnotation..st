visiting
visitPillarClassAnnotation: aGtPillarClassAnnotation 
	self targetText 
		attributes: {
			BrTextHoverAttribute new beNotOverwritableByStyler.
			BrTextClickAttribute new beNotOverwritableByStyler }
		from: aGtPillarClassAnnotation start 
		to: aGtPillarClassAnnotation stop.