class - missing one
textElementWithNonExistingClassAnnotation
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithNonExistingClassAnnotation.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement