failed executable code snippet
textElementWithFailedExecutableCodeSnippet
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithFailedExecutableCodeSnippet.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement