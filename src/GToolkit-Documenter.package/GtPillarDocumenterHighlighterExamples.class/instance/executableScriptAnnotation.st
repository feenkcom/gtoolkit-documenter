highlighted text
executableScriptAnnotation
	<gtExample>
	| aText |
	aText := '[[[
4 factorial
]]]' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	^ aText