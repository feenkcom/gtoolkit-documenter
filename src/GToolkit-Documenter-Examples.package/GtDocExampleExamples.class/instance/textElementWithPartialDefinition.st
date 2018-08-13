partial example definition
textElementWithPartialDefinition
	<gtExample>
	<label: 'Pillar element with an example with partial definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithPartialDefinition.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement