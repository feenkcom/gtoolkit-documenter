simple example definition
documentWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Document with an example code snippet'>
	| aTextElement aDocument documentPart |
	aTextElement := self textElementWithOneExampleCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	documentPart := aDocument documentParts documentPartAt: 1.
	self 
		assert: documentPart class 
		equals: GtPillarExample.
	self assert: documentPart result isNil.
	^ aDocument