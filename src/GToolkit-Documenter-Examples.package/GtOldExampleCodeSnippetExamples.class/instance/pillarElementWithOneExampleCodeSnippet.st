simple example definition
pillarElementWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Pillar element with an example code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithOneExampleCodeSnippet.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	^ pillarElement