method - existing expanded
textElementWithExpandedMethodAnnotation
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExpandedMethodAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement