grammar - Format
italicMarkup
	^ super italicMarkup ==> [ :token | 
		PRItalicFormat new start: token start; stop: token stop ]