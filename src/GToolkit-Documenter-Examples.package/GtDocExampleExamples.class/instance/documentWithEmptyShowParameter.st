example with empty show definition
documentWithEmptyShowParameter
	<gtExample>
	<label: 'Document with an example with an empty show parameter'>
	| aTextElement aDocument aDocumentPart |
	aTextElement := self textElementWithEmptyShowParameter.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument