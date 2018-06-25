accessing
monospaceFormat
	^ super monospaceFormat token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]