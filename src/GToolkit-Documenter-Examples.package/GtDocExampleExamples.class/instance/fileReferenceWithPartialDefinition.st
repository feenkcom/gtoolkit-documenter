partial example definition
fileReferenceWithPartialDefinition
	<gtExample>
	<label: 'Pillar file reference with an example with partial definition'>
	| fileReference |
	fileReference := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithPartialDefinition.
	self assert: fileReference exists.
	self assert: fileReference contents size > 1.
	^ fileReference