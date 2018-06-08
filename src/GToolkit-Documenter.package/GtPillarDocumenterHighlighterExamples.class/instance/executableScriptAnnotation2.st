highlighted text
executableScriptAnnotation2
	<gtExample>
	| aText |
	aText := '[[[
aResult := 4 factorial.
]]]' asRopedText.
	^ GtDocumenter editorForText: aText.