self reference
pillarElementWithSelfReference
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithSelfReference.
	pillarElement := GtOldDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	^ pillarElement