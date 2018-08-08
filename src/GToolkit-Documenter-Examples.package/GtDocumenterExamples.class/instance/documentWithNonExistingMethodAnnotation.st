method - missing one
documentWithNonExistingMethodAnnotation
	<gtExample>
	<label: 'Pillar document with method annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistingMethodAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument