accessing
annotatedParagraph
	^ super annotatedParagraph token ==> [ :token | 
		token parsedValue 
			start: token start;
			stop: token stop ]