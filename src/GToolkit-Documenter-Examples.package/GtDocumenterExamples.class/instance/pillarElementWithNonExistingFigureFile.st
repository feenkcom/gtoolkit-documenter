figure - not existing file
pillarElementWithNonExistingFigureFile
	<gtExample>
	| aFileReference aPillarElement |
	aFileReference := self documentWithFigure.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	^ aPillarElement