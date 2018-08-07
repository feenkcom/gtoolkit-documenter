class - existing expanded
documentWithExpandedClassAnnotation
	<gtExample>
	<label: 'Pillar document with class annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedClassAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument