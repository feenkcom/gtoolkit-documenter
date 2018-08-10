another language
documentWithBash
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithBash.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 1.
	codeSnippet := aDocument documentParts documentPartAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtPillarCodeblock.
	self 
		assert: codeSnippet pillarNode language
		equals: PRBashScriptLanguage default.
	self assert: codeSnippet result isNil.
	^ aDocument