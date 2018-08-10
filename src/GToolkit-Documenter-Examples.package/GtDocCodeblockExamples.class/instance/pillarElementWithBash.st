another language
pillarElementWithBash
	<gtExample>
	<label: 'Pillar element with an executable code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithBash.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	^ pillarElement