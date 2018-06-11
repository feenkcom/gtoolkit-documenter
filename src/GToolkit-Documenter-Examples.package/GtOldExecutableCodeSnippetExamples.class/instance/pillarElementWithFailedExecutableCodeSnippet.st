failed executable code snippet
pillarElementWithFailedExecutableCodeSnippet
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithFailedExecutableCodeSnippet.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	^ pillarElement