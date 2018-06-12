partial example definition
documentWithPartialDefinition
	<gtExample>
	<label: 'Document with an example with partial definition'>
	| aPillarElement aDocument aDocumentPart |
	aPillarElement := self pillarElementWithPartialDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument