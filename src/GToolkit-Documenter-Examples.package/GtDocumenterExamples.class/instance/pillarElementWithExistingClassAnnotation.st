class - existing one
pillarElementWithExistingClassAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithClassAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement