examples - classes
textElementWithExamplesAnnotationUsingClasses
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExamplesAnnotationUsingClasses.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement