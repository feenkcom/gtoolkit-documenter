out bindings
setCodeSnippetResult
	<gtExample>
	| bindings |
	bindings := self codeSnippetWithPlaygroundBindings.
	bindings at: self variableOneName put: 42.
	self assert: bindings result value isNil.
	^ bindings