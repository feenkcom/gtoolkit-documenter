examples - classes
pillarElementWithExamplesAnnotationUsingClasses
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithExamplesAnnotationUsingClasses.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement