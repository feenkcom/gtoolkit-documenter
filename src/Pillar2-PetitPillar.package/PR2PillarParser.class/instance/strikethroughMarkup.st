grammar - Format
strikethroughMarkup
	^ super strikethroughMarkup ==> [ :token | 
		PRStrikethroughFormat new start: token start; stop: token stop ]