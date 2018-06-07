highlighted text
exampleAnnotation
	<gtExample>
	| aText |
	aText := '${example:GtPillarDocumenterHighlighterExamples>>#exampleAnnotation}$' asRopedText.
	GtPillarDocumenterHighlighter highlight: aText.
	^ aText