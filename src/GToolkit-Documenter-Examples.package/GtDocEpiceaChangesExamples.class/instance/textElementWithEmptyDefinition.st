empty definition
textElementWithEmptyDefinition
	<gtExample>
	<label: 'Pillar element with an Epicea code changes with empty definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement