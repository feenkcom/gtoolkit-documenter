accessing
directory
	^ directory ifNil: [ FileSystem workingDirectory ]