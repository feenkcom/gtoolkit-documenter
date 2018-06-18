grammar - Paragraph
annotatedParagraph
	^ (Markups at: PRAnnotatedParagraph) asPParser , ($  asPParser / newline) negate star flatten , ($  asPParser , oneLineContent) optional