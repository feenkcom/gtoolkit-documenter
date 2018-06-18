grammar - Annotation
annotation
	^ super annotation
		==>
			[ :array | 
				(array second withParameters: (array third ifNil: [ OrderedDictionary new ]))
					start: array first start;
					stop: array fourth stop ]