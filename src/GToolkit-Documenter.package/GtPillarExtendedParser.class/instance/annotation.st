accessing
annotation
	^ super annotation token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]