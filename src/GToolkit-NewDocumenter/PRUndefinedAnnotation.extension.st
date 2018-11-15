Extension { #name : #PRUndefinedAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRUndefinedAnnotation >> styleText: aBlRope [ 
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: Gt2DocumentConstants linkWithErrorColor
]
