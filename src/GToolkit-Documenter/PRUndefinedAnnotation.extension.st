Extension { #name : #PRUndefinedAnnotation }

{ #category : #'*GToolkit-Documenter' }
PRUndefinedAnnotation >> styleTextWithMarkup: aBlRope [
	super styleTextWithMarkup: aBlRope.
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: self constants linkWithErrorColor
]

{ #category : #'*GToolkit-Documenter' }
PRUndefinedAnnotation >> styleTextWithoutMarkup: aBlRope [
	self styleTextWithMarkup: aBlRope
]
