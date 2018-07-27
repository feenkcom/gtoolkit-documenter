out bindings
setCodeSnippetResult2
	<gtExample>
	| bindings |
	bindings := self codeSnippetWithPlaygroundBindings.
	bindings at: GtDocumenterConstants resultVariableName put: 42.
	self assert: bindings result notNil.
	self assert: bindings result key equals: GtDocumenterConstants resultVariableName.
	self assert: bindings result value equals: 42.
	^ bindings