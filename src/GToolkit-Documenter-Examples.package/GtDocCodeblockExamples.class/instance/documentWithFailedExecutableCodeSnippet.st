failed executable code snippet
documentWithFailedExecutableCodeSnippet
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aTextElement aDocument codeSnippet |
	aTextElement := self textElementWithFailedExecutableCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 1.
	codeSnippet := aDocument documentParts documentPartAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtPillarCodeblock.
	self assert: codeSnippet result isNil.
	^ aDocument