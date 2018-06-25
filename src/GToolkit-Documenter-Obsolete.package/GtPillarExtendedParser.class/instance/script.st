accessing
script
	^ super script token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]