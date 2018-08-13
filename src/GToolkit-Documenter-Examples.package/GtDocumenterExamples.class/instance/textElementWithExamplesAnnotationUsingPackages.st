examples - packages
textElementWithExamplesAnnotationUsingPackages
	<gtExample>
	| aFileReference aTextElement |
	aFileReference := self documentWithExamplesAnnotationUsingPackages.
	aTextElement := GtDocumenterExamplesUtility textElementForPillarFileReference: aFileReference.
	self assert: aTextElement notNil.
	^ aTextElement