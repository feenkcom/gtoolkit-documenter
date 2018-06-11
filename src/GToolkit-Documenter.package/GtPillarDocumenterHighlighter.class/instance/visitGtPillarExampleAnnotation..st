visiting
visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation
	| aPillarDocumentPart |
	outsCounter incrementAt: 1.
	aGtPillarExampleAnnotation counter: outsCounter copy.
	aPillarDocumentPart := GtDocumentPartFinder new
		document: self document;
		pillarNode: aGtPillarExampleAnnotation;
		documentPartClass: GtPillarExample;
		find.
	GtPillarExampleHighlighter highlight: aPillarDocumentPart using: self.