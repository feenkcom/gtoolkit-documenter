examples - packages
documentWithExamplesAnnotationUsingPackages
	<gtExample>
	<label: 'Pillar document with examples annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExamplesAnnotationUsingPackages.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument