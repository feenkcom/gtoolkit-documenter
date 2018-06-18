tests - Format
testMonospaceFormat
	super testMonospaceFormat.
	self assert: result equals: (PRMonospaceFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.