grammar - Format
subscriptMarkup
	^ super subscriptMarkup ==> [ :token | 
		PRSubscriptFormat new start: token start; stop: token stop ]