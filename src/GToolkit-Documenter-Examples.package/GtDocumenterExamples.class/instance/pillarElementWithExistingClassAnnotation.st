class - existing one
pillarElementWithExistingClassAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExistingClassAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement