grammar - Script
script
	| endParser |
	endParser := newline asPParser , (EndMarkups at: PRCodeblock) asPParser , space star , lineEnd.
	^	#epsilon asPParser token, 
		(Markups at: PRCodeblock) asPParser , 
		scriptParameters , 
		endParser negate plus flatten , 
		endParser,
		#epsilon asPParser token