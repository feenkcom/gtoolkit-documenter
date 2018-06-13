highlighted text
executableScriptAnnotation2
	<gtExample>
	| aText |
	aText := '
adslfkj daslfkj alsdfkj 
	
[[[
aResult ifNil: [ aResult := 2 ].
aResult := aResult * aResult.
]]]

ldsfjlkasdjf alsdfjlk asldfj' asRopedText.
	^ GtDocumenter editorForText: aText.