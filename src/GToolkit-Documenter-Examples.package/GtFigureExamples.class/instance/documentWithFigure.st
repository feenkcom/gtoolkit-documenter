document
documentWithFigure
	<gtExample>
	<label: 'Pillar document with figure'>
	| rootDocument |
	rootDocument := fileSystemExamples addPillarFileWithContent: 
		self pillarContentWithFigure.
	self assert: rootDocument exists.
	self assert: rootDocument contents size > 1.
	^ rootDocument