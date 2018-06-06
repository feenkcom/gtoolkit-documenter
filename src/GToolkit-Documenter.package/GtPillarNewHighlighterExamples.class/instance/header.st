highlighted text
header
	<gtExample>
	| aText |
	aText := '! Hello' asRopedText.
	GtPillarNewHighlighter highlight: aText.
	self assert: aText rope attributes size equals: 1.
	^ aText