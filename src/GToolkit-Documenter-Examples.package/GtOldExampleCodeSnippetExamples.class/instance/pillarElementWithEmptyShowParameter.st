example with empty show definition
pillarElementWithEmptyShowParameter
	<gtExample>
	<label: 'Pillar element with an example code snippet with an empty show parameter'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyShowParameter.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement