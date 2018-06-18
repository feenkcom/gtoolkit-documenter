grammar - Paragraph
annotatedParagraph
	^ super annotatedParagraph
		==> [ :array | 
				self halt.
				PRAnnotatedParagraph withAll: (array third value
					ifNil: [ {} ] 
					ifNotNil: [ :value | value ]) 
						annotation: array second value ]