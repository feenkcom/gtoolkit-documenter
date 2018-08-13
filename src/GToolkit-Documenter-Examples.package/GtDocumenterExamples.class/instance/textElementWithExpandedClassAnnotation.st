class - existing expanded
textElementWithExpandedClassAnnotation
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExpandedClassAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement