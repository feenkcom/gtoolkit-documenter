another language
textElementWithBash
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithBash.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement