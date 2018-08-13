non-existent example method
textElementWithNonExistentExampleMethod
	<gtExample>
	<label: 'Pillar element with an example with non-existent example method'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithNonExistentExampleMethod.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement