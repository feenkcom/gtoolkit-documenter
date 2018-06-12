example with empty show definition
fileReferenceWithEmptyShowParameter
	<gtExample>
	<label: 'Pillar file reference with an example with an empty show parameter'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithEmptyShowParameter.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference