document
outsFromEmptyDocument
	<gtExample>
	<label: 'Default document'>
	| document outs |
	self flag: 'Rething this example'.
	true ifTrue: [ ^ nil ].
	document := self emptyDocument.
	outs := document bindingOf: GtDocumenterConstants resultsVariableName.
	self assert: outs notNil.
	self assert: outs key equals: GtDocumenterConstants resultsVariableName.
	self assert: outs value notNil.
	self assert: outs value size isZero.
	^ outs value