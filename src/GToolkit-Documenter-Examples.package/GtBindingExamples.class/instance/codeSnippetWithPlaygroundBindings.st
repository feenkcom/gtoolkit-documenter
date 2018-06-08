out bindings
codeSnippetWithPlaygroundBindings
	<gtExample>
	<label: 'Code snippet with playground bindings'>
	| bindings playground |
	playground := self playgroundBindings.
	bindings := self outBindings.
	bindings bindings: playground.
	self assert: bindings bindings equals: playground.
	^ bindings