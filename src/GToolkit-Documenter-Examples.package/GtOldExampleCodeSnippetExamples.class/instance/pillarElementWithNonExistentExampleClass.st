non-existent example class
pillarElementWithNonExistentExampleClass
	<gtExample>
	<label: 'Pillar element with an example code snippet with non-existent example class'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithNonExistentExampleClass.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement