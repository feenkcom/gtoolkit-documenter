accessing
unorderedListItem
	^ super unorderedListItem token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]