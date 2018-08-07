method - existing one
pillarElementWithExistingMethodAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExistingMethodAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement