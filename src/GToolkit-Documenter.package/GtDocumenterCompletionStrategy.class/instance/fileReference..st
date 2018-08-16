initialization
fileReference: aFileReference
	directory := (aFileReference exists and: [ aFileReference isDirectory ])
		ifTrue: [ aFileReference ]
		ifFalse: [ aFileReference parent ]