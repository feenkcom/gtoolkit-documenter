example with expanded preview
documentWithExpandedPreview
	<gtExample>
	<label: 'Document with an example with expanded preview'>
	| aPillarElement aDocument aDocumentPart |
	aPillarElement := self pillarElementWithExpandedPreview.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument