executable code snippet
textElementWithOneExecutableCodeSnippet
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithOneExecutableCodeSnippet.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	^ aTextElement