empty example definition
documentWithEmptyDefinition
	<gtExample>
	<label: 'Document with an example with empty definition'>
	| aTextElement aDocument |
	aTextElement := self textElementWithEmptyDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument