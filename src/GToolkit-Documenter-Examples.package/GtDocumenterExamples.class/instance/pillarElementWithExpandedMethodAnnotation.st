method - existing expanded
pillarElementWithExpandedMethodAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExpandedMethodAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement