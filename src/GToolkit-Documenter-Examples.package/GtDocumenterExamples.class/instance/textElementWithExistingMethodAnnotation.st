method - existing one
textElementWithExistingMethodAnnotation
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExistingMethodAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement