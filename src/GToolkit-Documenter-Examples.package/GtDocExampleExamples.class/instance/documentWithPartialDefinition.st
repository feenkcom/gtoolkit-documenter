partial example definition
documentWithPartialDefinition
	<gtExample>
	<label: 'Document with an example with partial definition'>
	| aTextElement aDocument |
	aTextElement := self textElementWithPartialDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument