visiting
visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation
	| anExecutableNode |
	outsCounter incrementAt: 1.
	aGtPillarExampleAnnotation counter: outsCounter copy.
	self flag: 'Here we should search for an existing executable node in document'.
	anExecutableNode := GtPillarExample 
		document: self document
		pillarNode: aGtPillarExampleAnnotation.
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color gray }
		from: aGtPillarExampleAnnotation start 
		to: aGtPillarExampleAnnotation stop.
	self targetText
		attributes: (self expandingAttributesForExampleAnnotation: anExecutableNode)
		from: aGtPillarExampleAnnotation stop
		to: aGtPillarExampleAnnotation stop