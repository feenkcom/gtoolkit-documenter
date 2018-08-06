accessing
rootHighlighter: aGtPillarDocumenterHighlighter
	self
		assert: [ aGtPillarDocumenterHighlighter notNil ] 
		description: [ 'Highlighter has to be initialized' ].
	rootHighlighter := aGtPillarDocumenterHighlighter