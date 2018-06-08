instance creation
highlight: aGtPillarExecutableNode using: aGtPillarDocumenterHighlighter
	<return: #GtPillarDocumentPartHighlighter>
	^ self new
		documentPart: aGtPillarExecutableNode;
		rootHighlighter: aGtPillarDocumenterHighlighter;
		highlight