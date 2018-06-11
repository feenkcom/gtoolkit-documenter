accessing
termListItem
	^ super termListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]