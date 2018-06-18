grammar - Format
underlineMarkup
	^ super underlineMarkup ==> [ :token | 
		PRUnderlineFormat new start: token start; stop: token stop ]