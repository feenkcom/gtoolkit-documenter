self reference
textElementWithSelfReference
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithSelfReference.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement