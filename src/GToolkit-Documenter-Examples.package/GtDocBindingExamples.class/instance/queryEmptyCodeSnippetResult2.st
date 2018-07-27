out bindings
queryEmptyCodeSnippetResult2
	<gtExample>
	<label: 'Query result of empty code snippet bindings'>
	| emptyBindings result |
	emptyBindings := self outBindings.
	result := emptyBindings
		bindingOf: GtDocumenterConstants resultVariableName.
	self assert: result isNil.
	^ emptyBindings