grammar - Header
header
	"A header begin by a certain amount of $! and contains a text and/or some formatedText"

	^ 	#epsilon asPParser token ,
		(Markups at: PRHeader) asPParser plus , 
		oneLineContent optional trimBlanks , 
		#epsilon asPParser token