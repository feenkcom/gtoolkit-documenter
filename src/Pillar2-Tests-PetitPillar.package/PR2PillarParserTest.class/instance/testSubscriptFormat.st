tests - Format
testSubscriptFormat
	super testSubscriptFormat.
	self assert: result equals: (PRSubscriptFormat with: (PRText content: 'Foo')).
	self assertStart: 1 stop: 7.