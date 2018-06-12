partial example definition
pillarElementWithPartialDefinition
	<gtExample>
	<label: 'Pillar element with an example with partial definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithPartialDefinition.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement