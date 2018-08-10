example with noCode parameter
pillarContentWithNoCodeParameter
	<gtExample>
	<label: 'Pillar content with an example'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants exampleTag;
			nextPutAll: ':';
			nextPutAll: self referencedExampleMethodName;
			nextPutAll: '|';
			nextPutAll: self constants doNotDisplaySourceCodeParameterName;
			nextPutAll: '}$' ]