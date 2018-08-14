example with expanded preview
documentWithExpandedPreview
	<gtExample>
	<label: 'Document with an example with expanded preview'>
	| aTextElement aDocument |
	aTextElement := self textElementWithExpandedPreview.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument