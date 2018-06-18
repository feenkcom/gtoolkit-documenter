tests - Format
testSuperscriptFormat
	super testSuperscriptFormat.
	self assert: result equals: (PRSuperscriptFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.