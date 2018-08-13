figure - existing file
textElementWithExistingFigureFile
	<gtExample>
	| aFileReference aTextElement aFigureFile |
	aFileReference := self documentWithFigure.
	aFigureFile := self figureFileReference.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	self assert: aFigureFile exists.
	^ aTextElement