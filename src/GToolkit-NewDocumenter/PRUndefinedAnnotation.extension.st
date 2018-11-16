Extension { #name : #PRUndefinedAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRUndefinedAnnotation >> styleTextEditingMode: aBlRope [
	super styleTextEditingMode: aBlRope.
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: self constants linkWithErrorColor
]

{ #category : #'*GToolkit-NewDocumenter' }
PRUndefinedAnnotation >> styleTextReadingMode: aBlRope [
	self styleTextEditingMode: aBlRope
]
