non-existent example class
textElementWithNonExistentExampleClass
	<gtExample>
	<label: 'Pillar element with an example with non-existent example class'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithNonExistentExampleClass.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement