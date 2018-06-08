visiting
visitCodeblock: aPRCodeblock
	| anExecutableNode |
	outsCounter incrementAt: 1.
	aPRCodeblock counter: outsCounter copy.
	self flag: 'Here we should search for an existing executable node in document'.
	anExecutableNode := GtPillarCodeblock
		document: self document
		pillarNode: aPRCodeblock.
	GtPillarExecutableCodeblockNodeHighlighter highlight: anExecutableNode using: self.