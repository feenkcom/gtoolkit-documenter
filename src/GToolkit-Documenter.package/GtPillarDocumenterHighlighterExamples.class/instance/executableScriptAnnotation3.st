highlighted text
executableScriptAnnotation3
	<gtExample>
	| aText |
	aText := '
[[[
aResult ifNil: [ aResult := 2 ].
aResult := aResult * aResult.
]]]
' asRopedText.
	^ GtDocumenter editorForText: aText.