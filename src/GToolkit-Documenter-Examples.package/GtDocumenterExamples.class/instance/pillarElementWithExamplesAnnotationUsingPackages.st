examples - packages
pillarElementWithExamplesAnnotationUsingPackages
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExamplesAnnotationUsingPackages.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement