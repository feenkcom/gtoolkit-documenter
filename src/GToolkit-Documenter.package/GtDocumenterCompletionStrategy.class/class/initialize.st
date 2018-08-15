class initialization
initialize
	ParameterValueCompletionSelectors := Dictionary new.
	ParameterValueCompletionSelectors
		at: GtPillarClassAnnotation
			put:
			(Dictionary new
				at: #name put: #classesStartingWith:;
				yourself);
		at: GtPillarEpiceaChangesAnnotation
			put:
			(Dictionary new
				at: #file put: #filenamesStartingWith:;
				yourself);
		at: GtPillarExampleAnnotation
			put:
			(Dictionary new
				at: #name put: #exampleMethodsStartingWith:;
				yourself);
		at: GtPillarMethodAnnotation
			put:
			(Dictionary new
				at: #name put: #methodsStartingWith:;
				yourself)