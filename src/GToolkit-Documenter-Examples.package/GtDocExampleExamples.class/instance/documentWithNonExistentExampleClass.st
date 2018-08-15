non-existent example class
documentWithNonExistentExampleClass
	<gtExample>
	<label: 'Document with an example with non-existent example class'>
	| aTextElement aDocument |
	aTextElement := self textElementWithNonExistentExampleClass.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 0.
	^ aDocument