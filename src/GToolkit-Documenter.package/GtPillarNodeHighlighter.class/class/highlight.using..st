instance creation
highlight: aPRDocumentItem using: aGtPillarDocumenterHighlighter
	<return: #GtPillarNodeHighlighter>
	^ self new
		pillarNode: aPRDocumentItem;
		rootHighlighter: aGtPillarDocumenterHighlighter;
		highlight