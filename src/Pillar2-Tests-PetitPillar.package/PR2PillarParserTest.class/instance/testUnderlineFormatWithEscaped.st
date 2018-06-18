tests - Format
testUnderlineFormatWithEscaped
	super testUnderlineFormatWithEscaped.
	self assert: result equals: (PRUnderlineFormat with: (PRText content: '__')).
	self assertStart: 1 stop: 8.