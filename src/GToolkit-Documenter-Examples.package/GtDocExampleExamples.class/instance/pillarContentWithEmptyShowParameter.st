example with empty show definition
pillarContentWithEmptyShowParameter
	<gtExample>
	<label: 'Pillar content with an example with an empty show parameter'>
	^ '${example:' , self referencedExampleMethodName , '|show=}$'