example with expanded preview
textElementWithExpandedPreview
	<gtExample>
	<label: 'Pillar element with an example with expanded preview'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithExpandedPreview.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement