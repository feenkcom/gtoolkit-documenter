visiting
visitAnnotatedParagraph: aPRAnnotatedParagraph
	self targetText 
		attributes: { BrTextForegroundAttribute paint: Color red muchDarker }
		from: aPRAnnotatedParagraph start 
		to: aPRAnnotatedParagraph stop.