tests - Format
testSuperscriptFormatWithEscaped
	super testSuperscriptFormatWithEscaped.
	self assert: result equals: (PRSuperscriptFormat with: (PRText content: '^^')).
	self assertStart: 1 stop: 8.