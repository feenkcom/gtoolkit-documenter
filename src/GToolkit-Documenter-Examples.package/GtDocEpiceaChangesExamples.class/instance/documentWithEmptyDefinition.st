empty example definition
documentWithEmptyDefinition
	<gtExample>
	<label: 'Document with an Epicea code changes with empty definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithEmptyDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument documentParts size equals: 0.
	"codeSnippet := aDocument documentParts codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtEpiceaChanges.
	self assert: codeSnippet result isNil."
	^ aDocument