example with noCode parameter
documentWithNoCodeParameter
	<gtExample>
	<label: 'Document with an example'>
	| aTextElement aDocument |
	aTextElement := self textElementWithNoCodeParameter.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument