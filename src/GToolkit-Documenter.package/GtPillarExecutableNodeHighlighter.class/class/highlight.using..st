instance creation
highlight: aGtPillarExecutableNode using: aGtPillarDocumenterHighlighter
	<return: #GtPillarExecutableNodeHighlighter>
	^ self new
		executableNode: aGtPillarExecutableNode;
		rootHighlighter: aGtPillarDocumenterHighlighter;
		highlight