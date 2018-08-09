empty example definition
pillarElementWithEmptyDefinition
	<gtExample>
	<label: 'Pillar element with an example with empty definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	pillarElement := GtDocumenterExamplesUtility 
			pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement