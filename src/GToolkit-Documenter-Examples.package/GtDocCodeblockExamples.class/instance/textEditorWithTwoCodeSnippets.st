editing live document
textEditorWithTwoCodeSnippets
	<gtExample>
	<label: 'Text editor'>
	| aBrEditorElement editor |
	aBrEditorElement := self textElementWithTwoCodeSnippets.
	editor := aBrEditorElement editor.
	self assert: editor notNil.
	self assert: editor styler document notNil.
	self assert: editor styler document documentParts size equals: 2.
	^ editor