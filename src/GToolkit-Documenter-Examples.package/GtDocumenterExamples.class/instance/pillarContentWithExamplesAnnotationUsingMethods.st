examples - methods
pillarContentWithExamplesAnnotationUsingMethods
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':';
			nextPutAll: self constants methodsParameterName;
			nextPutAll: '=#(';
			print: self referencedMethod;
			space;
			print: self referencedMethodTwo;
			nextPutAll: ')}$' ]
