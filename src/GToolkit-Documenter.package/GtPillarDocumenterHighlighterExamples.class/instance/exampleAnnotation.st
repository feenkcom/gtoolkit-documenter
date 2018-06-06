highlighted text
exampleAnnotation
	<gtExample>
	| aText |
	aText := '${example:GtPillarNewHighlighterExamples>>#exampleAnnotation}$' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 2.
	^ aText