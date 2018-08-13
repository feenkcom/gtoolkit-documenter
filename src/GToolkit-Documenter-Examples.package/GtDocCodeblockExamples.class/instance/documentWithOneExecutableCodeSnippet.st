executable code snippet
documentWithOneExecutableCodeSnippet
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument aDocumentPart |
	aTextElement := self textElementWithOneExecutableCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	aDocumentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: aDocumentPart class 
		equals: GtPillarCodeblock.
	self assert: aDocumentPart result isNil.
	^ aDocument