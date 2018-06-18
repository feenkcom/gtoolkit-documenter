grammar - Format
boldMarkup
	^ super boldMarkup ==> [ :token | 
		PRBoldFormat new start: token start; stop: token stop ]