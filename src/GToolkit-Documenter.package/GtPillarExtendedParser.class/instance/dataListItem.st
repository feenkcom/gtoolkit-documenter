accessing
dataListItem
	^ super dataListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]