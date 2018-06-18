tests - Format
testItalicFormat
	super testItalicFormat.
	self assert: result equals: (PRItalicFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.