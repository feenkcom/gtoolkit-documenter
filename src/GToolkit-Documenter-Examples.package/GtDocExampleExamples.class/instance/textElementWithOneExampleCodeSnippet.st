simple example definition
textElementWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Pillar element with an example code snippet'>
	| fileReference aTextElement |
	fileReference := self fileReferenceWithOneExampleCodeSnippet.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: fileReference.
	self assert: aTextElement notNil.
	(GtDocumenterExamplesUtility editorFromTextElement: aTextElement) styleText.
	^ aTextElement