example with empty show definition
documentWithEmptyShowParameter
	<gtExample>
	<label: 'Document with an example with an empty show parameter'>
	| aTextElement aDocument |
	aTextElement := self textElementWithEmptyShowParameter.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument