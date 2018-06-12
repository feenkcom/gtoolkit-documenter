simple example definition
documentWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Document with an example code snippet'>
	| aPillarElement aDocument documentPart |
	aPillarElement := self pillarElementWithOneExampleCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	documentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: documentPart class 
		equals: GtPillarExample.
	self assert: documentPart result isNil.
	^ aDocument