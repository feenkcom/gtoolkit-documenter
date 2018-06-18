grammar - Format
superscriptMarkup
	^ super superscriptMarkup ==> [ :token | 
		PRSuperscriptFormat new start: token start; stop: token stop ]