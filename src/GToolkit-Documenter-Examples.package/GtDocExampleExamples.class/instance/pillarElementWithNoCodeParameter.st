example with noCode parameter
pillarElementWithNoCodeParameter
	<gtExample>
	<label: 'Pillar element with an example'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithNoCodeParameter.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement