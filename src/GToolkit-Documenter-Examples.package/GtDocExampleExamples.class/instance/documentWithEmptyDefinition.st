empty example definition
documentWithEmptyDefinition
	<gtExample>
	<label: 'Document with an example with empty definition'>
	| aPillarElement aDocument aDocumentPart |
	aPillarElement := self pillarElementWithEmptyDefinition.
	self flag: 'We should handle PRError differently'.
	aPillarElement class = PRError ifTrue: [ ^ aPillarElement ].
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarExample.
	self assert: aDocumentPart result isNil.
	^ aDocument