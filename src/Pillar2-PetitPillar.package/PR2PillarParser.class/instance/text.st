grammar - Text
text
	"A text is a PRText with a string that contains any character inside."

	^ super text
		==> [ :token | 
			"| stream |
			stream := '' writeStream.
			token do: [ :letter | stream nextPut: letter ]."
			(PRText content: token value)
				start: token start;
				stop: token stop ]