class - existing one
textElementWithExistingClassAnnotation
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExistingClassAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement