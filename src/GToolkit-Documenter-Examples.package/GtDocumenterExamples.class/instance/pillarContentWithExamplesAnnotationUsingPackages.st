examples - packages
pillarContentWithExamplesAnnotationUsingPackages
	<gtExample>
	<label: 'Pillar content with examples annotation'>
	^ String streamContents: [ :aStream | 
		aStream 
			nextPutAll: '${';
			nextPutAll: self constants examplesTag;
			nextPutAll: ':';
			nextPutAll: self constants packagesParameterName;
			nextPutAll: '=#(';
			print: self class package name asString;
			nextPutAll: ')}$' ]