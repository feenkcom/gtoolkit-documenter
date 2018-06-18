grammar - Paragraph
annotatedParagraph
	^ super annotatedParagraph
		==> [ :array | 
				(PRAnnotatedParagraph 
					withAll: (array third
						ifNil: [ {} ] 
						ifNotNil: [ :elem | elem second ]) 
					annotation: array second value)
						start: array first start;
						stop: (array third
							ifNil: [ array second stop ] 
							ifNotNil: [ :elem | elem second last stop ]) ]