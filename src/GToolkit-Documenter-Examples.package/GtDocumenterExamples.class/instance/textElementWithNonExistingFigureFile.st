figure - not existing file
textElementWithNonExistingFigureFile
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithFigure.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement