executable code snippet
documentWithOneExecutableCodeSnippet
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aPillarElement aDocument aDocumentPart |
	aPillarElement := self pillarElementWithOneExecutableCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarCodeblock.
	self assert: aDocumentPart result isNil.
	^ aDocument