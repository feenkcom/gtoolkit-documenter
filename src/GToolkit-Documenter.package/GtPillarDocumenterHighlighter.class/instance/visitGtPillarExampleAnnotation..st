visiting
visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation
	| aPillarDocumentPart |
	outsCounter incrementAt: 1.
	aGtPillarExampleAnnotation counter: outsCounter copy.
	self flag: 'Here we should search for an existing executable node in document'.
	aPillarDocumentPart := GtPillarExample 
		document: self document
		pillarNode: aGtPillarExampleAnnotation.
	GtPillarExampleHighlighter highlight: aPillarDocumentPart using: self.