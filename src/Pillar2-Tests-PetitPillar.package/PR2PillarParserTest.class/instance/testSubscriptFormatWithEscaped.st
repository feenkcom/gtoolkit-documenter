tests - Format
testSubscriptFormatWithEscaped
	super testSubscriptFormatWithEscaped.
	self assert: result equals: (PRSubscriptFormat with: (PRText content: '@@')).
	self assertStart: 1 stop: 8.