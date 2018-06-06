highlighted text
annotatedParagraph
	<gtExample>
	| aText |
	aText := '@@todo annotated paragraph' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 1.
	^ aText