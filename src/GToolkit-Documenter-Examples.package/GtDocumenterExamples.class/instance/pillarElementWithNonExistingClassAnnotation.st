class - missing one
pillarElementWithNonExistingClassAnnotation
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithNonExistingClassAnnotation.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement