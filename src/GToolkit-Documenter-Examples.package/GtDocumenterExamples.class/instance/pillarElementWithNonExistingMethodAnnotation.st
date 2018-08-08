method - missing one
pillarElementWithNonExistingMethodAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithNonExistingMethodAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement