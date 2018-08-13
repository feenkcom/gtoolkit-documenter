non-existent example class
documentWithNonExistentExampleClass
	<gtExample>
	<label: 'Document with an example with non-existent example class'>
	| aTextElement aDocument aDocumentPart |
	aTextElement := self textElementWithNonExistentExampleClass.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument