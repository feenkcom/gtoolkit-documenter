example with expanded preview
pillarElementWithExpandedPreview
	<gtExample>
	<label: 'Pillar element with an example code snippet with expanded preview'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithExpandedPreview.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtOldDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement