tests - Format
testBoldFormatWithEscaped
	super testBoldFormatWithEscaped.
	self assert: result equals: (PRBoldFormat with: (PRText content: '""')).
	self assertStart: 1 stop: 8.