examples - classes
pillarContentWithExamplesAnnotationUsingClasses
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':';
			nextPutAll: self constants classesParameterName;
			nextPutAll: '=#(';
			nextPutAll: self referencedClass;
			nextPutAll: ')}$' ]
