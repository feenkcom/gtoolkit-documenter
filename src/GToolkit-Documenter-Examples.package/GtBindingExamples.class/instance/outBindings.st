out bindings
outBindings
	<gtExample>
	<label: 'Default out bindings'>
	| bindings |
	bindings := GtOutBindings new.
	self assert: bindings result isNil.
	self assert: bindings hasResult not.
	^ bindings