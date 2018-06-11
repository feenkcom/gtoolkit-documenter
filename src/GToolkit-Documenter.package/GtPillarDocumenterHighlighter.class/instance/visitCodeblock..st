visiting
visitCodeblock: aPRCodeblock
	| aDocumentPart |
	outsCounter incrementAt: 1.
	aPRCodeblock counter: outsCounter copy.
	aDocumentPart := GtDocumentPartFinder new
		document: self document;
		pillarNode: aPRCodeblock;
		documentPartClass: GtPillarCodeblock;
		find.
	GtPillarCodeblockHighlighter highlight: aDocumentPart using: self.