accessing
orderedListItem
	^ super orderedListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]