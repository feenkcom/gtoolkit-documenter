Extension { #name : #PRUndefinedAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRUndefinedAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: self constants linkWithErrorColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRUndefinedAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope
]
