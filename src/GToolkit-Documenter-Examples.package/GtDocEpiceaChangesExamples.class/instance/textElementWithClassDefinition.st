class definition
textElementWithClassDefinition
	<gtExample>
	<label: 'Pillar element with Epicea changes with class definition'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithClassDefinition.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	self assert: aTextElement notNil.
	^ aTextElement