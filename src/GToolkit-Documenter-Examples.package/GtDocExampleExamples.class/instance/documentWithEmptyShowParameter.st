example with empty show definition
documentWithEmptyShowParameter
	<gtExample>
	<label: 'Document with an example with an empty show parameter'>
	| aPillarElement aDocument aDocumentPart |
	aPillarElement := self pillarElementWithEmptyShowParameter.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument