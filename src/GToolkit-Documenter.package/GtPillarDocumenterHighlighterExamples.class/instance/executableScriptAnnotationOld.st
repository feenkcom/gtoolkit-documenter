highlighted text
executableScriptAnnotationOld
	<gtExample>
	| aText |
	aText := '[[[
aResult := 4 factorial.
]]]' asRopedText.
	GtOldPillarHighlightingParser new
		targetText: aText;
		workspace: GtDocument new;
		parse: aText asString.
	^ aText