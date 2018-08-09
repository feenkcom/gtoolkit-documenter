examples - methods
pillarElementWithExamplesAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExamplesAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement