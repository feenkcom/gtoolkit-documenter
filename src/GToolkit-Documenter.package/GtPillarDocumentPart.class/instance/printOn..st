printing
printOn: aStream
	super printOn: aStream.
	self pillarNode ifNil: [ ^ self ].
	aStream
		nextPutAll: '[index=';
		print: self index;
		nextPutAll: ']'