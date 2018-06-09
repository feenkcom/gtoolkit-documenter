visiting
visitCodeblock: aPRCodeblock
	| aDocumentPart |
	outsCounter incrementAt: 1.
	aPRCodeblock counter: outsCounter copy.
	self flag: 'Here we should search for an existing executable node in document'.
	aDocumentPart := GtDocumentPartFinder new
		document: self document;
		pillarNode: aPRCodeblock;
		documentPartClass: GtPillarCodeblock;
		find.
	"anExecutableNode := GtPillarCodeblock
		document: self document
		pillarNode: aPRCodeblock."
	GtPillarCodeblockHighlighter highlight: aDocumentPart using: self.