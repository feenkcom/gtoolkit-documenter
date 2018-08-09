examples - methods
documentWithExamplesAnnotation
	<gtExample>
	<label: 'Pillar document with examples annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExamplesAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument