visiting
visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation
	outsCounter incrementAt: 1.
	aGtPillarExampleAnnotation counter: outsCounter copy.
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color gray }
		from: aGtPillarExampleAnnotation start 
		to: aGtPillarExampleAnnotation stop.
	self targetText
		attributes: (self expandingAttributesForExampleAnnotation: aGtPillarExampleAnnotation)
		from: aGtPillarExampleAnnotation stop
		to: aGtPillarExampleAnnotation stop