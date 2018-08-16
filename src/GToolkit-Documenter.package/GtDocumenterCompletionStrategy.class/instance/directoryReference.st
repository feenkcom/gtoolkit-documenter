accessing
directoryReference
	^ directory ifNil: [ FileSystem workingDirectory ]