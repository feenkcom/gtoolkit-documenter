accessing
definitionList
	^ super definitionList token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]