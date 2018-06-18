tests - Paragraph
testAnnotatedParagraph
	super testAnnotatedParagraph.
	self 
		assert: result 
		equals: (PRAnnotatedParagraph withAll: {PRText content: 'Bar'} annotation: 'foo').
	self assertStart: 1 stop: 9.