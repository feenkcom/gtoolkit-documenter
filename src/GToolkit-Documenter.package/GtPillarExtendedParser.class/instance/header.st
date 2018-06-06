accessing
header
	^ super header token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]