examples - methods
textElementWithExamplesAnnotationUsingMethods
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExamplesAnnotationUsingMethods.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement