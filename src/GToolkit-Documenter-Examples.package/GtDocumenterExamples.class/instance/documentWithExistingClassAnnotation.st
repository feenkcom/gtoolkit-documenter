class - existing one
documentWithExistingClassAnnotation
	<gtExample>
	<label: 'Pillar document with class annotation'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithExistingClassAnnotation.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument