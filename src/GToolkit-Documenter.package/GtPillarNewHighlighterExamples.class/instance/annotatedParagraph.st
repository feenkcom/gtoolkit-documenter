highlighted text
annotatedParagraph
	<gtExample>
	| aText |
	aText := '@@todo annotated paragraph' asRopedText.
	GtPillarNewHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 1.
	^ aText