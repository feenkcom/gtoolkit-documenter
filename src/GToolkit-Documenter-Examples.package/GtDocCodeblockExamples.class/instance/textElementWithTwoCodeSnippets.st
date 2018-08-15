editing live document
textElementWithTwoCodeSnippets
	<gtExample>
	<label: 'Pillar Bloc element'>
	| aFileReference aTextElement aDocument |
	aFileReference := self rootDocumentForAddingAndRemovingCodeSnippets.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	aDocument := GtDocumenterExamplesUtility documentFromTextElement: aTextElement.
	self assert: aDocument documentParts size equals: 2.
	^ aTextElement