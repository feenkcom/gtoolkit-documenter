empty definition
pillarElementWithEmptyDefinition
	<gtExample>
	<label: 'Pillar element with an example code snippet with empty definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement