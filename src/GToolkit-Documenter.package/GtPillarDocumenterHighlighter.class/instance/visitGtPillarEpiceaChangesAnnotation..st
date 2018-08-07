as yet unclassified
visitGtPillarEpiceaChangesAnnotation: aGtPillarEpiceaChangesAnnotation
	| aPillarDocumentPart |
	aPillarDocumentPart := GtEpiceaChanges new
		document: self document;
		sourceFileReference: self fileReference;
		pillarNode: aGtPillarEpiceaChangesAnnotation.
	GtPillarEpiceaChangesHighlighter highlight: aPillarDocumentPart using: self.