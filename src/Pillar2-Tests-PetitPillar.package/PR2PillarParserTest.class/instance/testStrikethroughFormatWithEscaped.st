tests - Format
testStrikethroughFormatWithEscaped
	super testStrikethroughFormatWithEscaped.
	self assert: result equals: (PRStrikethroughFormat with: (PRText content: '--')).
	self assertStart: 1 stop: 8.