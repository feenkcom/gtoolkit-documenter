example with noCode parameter
fileReferenceWithNoCodeParameter
	<gtExample>
	<label: 'Pillar file reference with an example'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithNoCodeParameter.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference