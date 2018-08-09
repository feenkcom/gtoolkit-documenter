examples - methods
pillarElementWithExamplesAnnotationUsingMethods
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExamplesAnnotationUsingMethods.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement