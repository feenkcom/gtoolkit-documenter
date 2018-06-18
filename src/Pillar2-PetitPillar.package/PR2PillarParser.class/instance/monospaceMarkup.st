grammar - Format
monospaceMarkup
	^ super monospaceMarkup ==> [ :token | 
		PRMonospaceFormat new start: token start; stop: token stop ]