visiting
visitAnnotatedParagraph: aPRAnnotatedParagraph
	(self targetText
		from: aPRAnnotatedParagraph start
		to: aPRAnnotatedParagraph stop)
			foreground: Color red muchDarker