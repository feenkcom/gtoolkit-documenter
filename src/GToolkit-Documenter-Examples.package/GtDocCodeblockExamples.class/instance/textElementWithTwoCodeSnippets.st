editing live document
textElementWithTwoCodeSnippets
	<gtExample>
	<label: 'Pillar Bloc element'>
	| rootDocument aTextElement |
	rootDocument := self rootDocumentForAddingAndRemovingCodeSnippets.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: rootDocument.
	self assert: aTextElement document documentParts size equals: 2.
	^ aTextElement