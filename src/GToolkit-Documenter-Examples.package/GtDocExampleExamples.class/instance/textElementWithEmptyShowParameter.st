example with empty show definition
textElementWithEmptyShowParameter
	<gtExample>
	<label: 'Pillar element with an example with an empty show parameter'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithEmptyShowParameter.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement