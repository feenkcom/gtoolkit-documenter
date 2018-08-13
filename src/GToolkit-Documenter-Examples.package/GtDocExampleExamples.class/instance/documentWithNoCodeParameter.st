example with noCode parameter
documentWithNoCodeParameter
	<gtExample>
	<label: 'Document with an example'>
	| aTextElement aDocument aDocumentPart |
	aTextElement := self textElementWithNoCodeParameter.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument