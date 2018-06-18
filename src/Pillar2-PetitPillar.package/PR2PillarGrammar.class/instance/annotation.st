grammar - Annotation
annotation
	self flag: #todo.	"An annotation should have the possibility to be outside of a paragraph."
	^ (Markups at: PRAbstractAnnotation) asPParser token , 
		annotationTag , 
		annotationParameters optional ,
		annotationEndMarkup token , 
		#blank asPParser star