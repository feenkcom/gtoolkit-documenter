non-existent example method
documentWithNonExistentExampleMethod
	<gtExample>
	<label: 'Document with an example with non-existent example method'>
	| aTextElement aDocument |
	aTextElement := self textElementWithNonExistentExampleMethod.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument