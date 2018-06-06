accessing
orderedList
	^ super orderedList token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]