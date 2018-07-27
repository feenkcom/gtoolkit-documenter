out bindings
queryEmptyCodeSnippetResult
	<gtExample>
	<label: 'Query empty code snippet bindings'>
	| emptyBindings result |
	emptyBindings := self outBindings.
	result := emptyBindings
		bindingOf: self variableOneName.
	self assert: result isNil.
	^ emptyBindings