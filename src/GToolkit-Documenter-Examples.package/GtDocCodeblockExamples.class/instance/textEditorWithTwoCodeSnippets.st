editing live document
textEditorWithTwoCodeSnippets
	<gtExample>
	<label: 'Text editor'>
	| pillarElement editor |
	pillarElement := self pillarElementWithTwoCodeSnippets.
	editor := pillarElement contentElement editor.
	self assert: editor notNil.
	self assert: editor styler document notNil.
	self assert: editor styler document documentParts size equals: 2.
	^ editor