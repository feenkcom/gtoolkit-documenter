self reference
documentWithSelfReference
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument codeSnippet |
	aTextElement := self textElementWithSelfReference.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	codeSnippet := aDocument documentParts documentPartAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtPillarCodeblock.
	self assert: codeSnippet result isNil.
	^ aDocument