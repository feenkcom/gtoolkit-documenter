empty example definition
textElementWithEmptyDefinition
	<gtExample>
	<label: 'Pillar element with an example with empty definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	aTextElement := GtDocumenterExamplesUtility 
			textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement