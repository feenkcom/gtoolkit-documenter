example with noCode parameter
textElementWithNoCodeParameter
	<gtExample>
	<label: 'Pillar element with an example'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithNoCodeParameter.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement