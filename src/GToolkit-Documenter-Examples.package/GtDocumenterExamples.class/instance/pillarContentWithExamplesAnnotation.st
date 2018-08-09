examples - methods
pillarContentWithExamplesAnnotation
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':#(';
			print: self referencedMethod;
			space;
			print: self referencedMethodTwo;
			nextPutAll: ')}$' ]
