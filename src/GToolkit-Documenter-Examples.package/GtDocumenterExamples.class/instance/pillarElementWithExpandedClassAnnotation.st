class - existing expanded
pillarElementWithExpandedClassAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExpandedClassAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement