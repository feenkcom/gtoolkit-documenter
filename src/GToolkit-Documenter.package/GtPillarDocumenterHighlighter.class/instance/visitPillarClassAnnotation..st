visiting
visitPillarClassAnnotation: aGtPillarClassAnnotation 
	self targetText 
		attributes: {
			BrTextHoverAttribute new beNotOverwritableByStyler.
			BrTextClickAttribute new 
				beNotOverwritableByStyler;
				action: [ :aText :aTarget :anEvent | 
					aGtPillarClassAnnotation browseClassFrom: anEvent ] }
		from: aGtPillarClassAnnotation start 
		to: aGtPillarClassAnnotation stop.