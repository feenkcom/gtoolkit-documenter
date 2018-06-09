highlighted text
executableScriptAnnotation
	<gtExample>
	| aText |
	aText := '[[[
aResult ifNil: [ aResult := 2 ].
aResult := aResult * aResult.
]]]' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	^ aText