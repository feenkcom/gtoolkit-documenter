highlighted text
headerAndMonospaceText
	<gtExample>
	| aText |
	aText := '! Hello

@@todo annotated paragraph

==monospace== text.
' asRopedText.
	^ GtPillarNewHighlighter
	 	highlight: aText.