document
documentWithTwoUninitializedCodeSnippets
	<gtExample>
	| codeSnippetOne document codeSnippetTwo result |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self emptyDocument.
	codeSnippetOne := self outBindings.
	codeSnippetOne index: 1.
	codeSnippetOne document: document.
	codeSnippetTwo := self outBindings.
	codeSnippetTwo index: 2.
	codeSnippetTwo document: document.
	result := codeSnippetTwo bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ document