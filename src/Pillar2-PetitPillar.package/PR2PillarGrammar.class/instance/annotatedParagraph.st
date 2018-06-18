grammar - Paragraph
annotatedParagraph
	^ (Markups at: PRAnnotatedParagraph) asPParser token, 
		($  asPParser / newline) negate star flatten token, 
		($  asPParser , oneLineContent) optional