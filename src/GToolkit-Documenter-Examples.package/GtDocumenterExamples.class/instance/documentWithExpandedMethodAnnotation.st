method - existing expanded
documentWithExpandedMethodAnnotation
	<gtExample>
	<label: 'Pillar document with method annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExpandedMethodAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument