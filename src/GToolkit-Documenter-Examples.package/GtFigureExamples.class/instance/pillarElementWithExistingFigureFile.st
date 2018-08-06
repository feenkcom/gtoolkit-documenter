existing figure file
pillarElementWithExistingFigureFile
	<gtExample>
	| aFileReference aPillarElement aFigureFile |
	aFileReference := self documentWithFigure.
	aFigureFile := self figureFileReference.
	aPillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: aFileReference.
	self assert: aPillarElement notNil.
	self assert: aFigureFile exists.
	^ aPillarElement