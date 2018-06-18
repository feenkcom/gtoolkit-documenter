grammar - Annotation
annotation
	self flag: #todo.	"An annotation should have the possibility to be outside of a paragraph."
	^ (Markups at: PRAbstractAnnotation) asPParser , annotationTag , annotationParameters optional
		, annotationEndMarkup , #blank asPParser star