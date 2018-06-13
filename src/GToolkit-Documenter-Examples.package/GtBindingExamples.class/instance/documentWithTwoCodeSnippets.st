document
documentWithTwoCodeSnippets
	<gtExample>
	| codeSnippet document out |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self documentWithOneCodeSnippet.
	codeSnippet := self outBindings.
	codeSnippet value: 7.
	codeSnippet index: 2.
	codeSnippet document: document.
	out := codeSnippet bindingOf: GtDocumenterConstants resultVariableName.
	self assert: out notNil.
	self assert: out value equals: 108.
	^ document