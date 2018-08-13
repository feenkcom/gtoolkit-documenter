empty example definition
documentWithEmptyDefinition
	<gtExample>
	<label: 'Document with an example with empty definition'>
	| aTextElement aDocument aDocumentPart |
	aTextElement := self textElementWithEmptyDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument