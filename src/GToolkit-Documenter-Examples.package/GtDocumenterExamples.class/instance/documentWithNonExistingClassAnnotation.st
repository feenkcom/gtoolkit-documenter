class - missing one
documentWithNonExistingClassAnnotation
	<gtExample>
	<label: 'Pillar document with class annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNonExistingClassAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument