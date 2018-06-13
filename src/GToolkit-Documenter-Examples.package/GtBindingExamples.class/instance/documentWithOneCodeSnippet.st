document
documentWithOneCodeSnippet
	<gtExample>
	| codeSnippet document |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self emptyDocument.
	codeSnippet := self outBindings.
	codeSnippet value: 108.
	codeSnippet index: 1.
	codeSnippet document: document.
	^ document