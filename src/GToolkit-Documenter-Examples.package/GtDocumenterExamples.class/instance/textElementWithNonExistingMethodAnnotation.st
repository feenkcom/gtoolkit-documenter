method - missing one
textElementWithNonExistingMethodAnnotation
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithNonExistingMethodAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement