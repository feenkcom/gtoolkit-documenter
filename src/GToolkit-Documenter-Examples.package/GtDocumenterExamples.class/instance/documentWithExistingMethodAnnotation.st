method - existing one
documentWithExistingMethodAnnotation
	<gtExample>
	<label: 'Pillar document with method annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExistingMethodAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument