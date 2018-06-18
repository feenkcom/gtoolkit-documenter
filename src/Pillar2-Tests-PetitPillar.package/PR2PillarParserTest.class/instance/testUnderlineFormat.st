tests - Format
testUnderlineFormat
	super testUnderlineFormat.
	self assert: result equals: (PRUnderlineFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.