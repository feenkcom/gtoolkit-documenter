Extension { #name : #PRUndefinedAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRUndefinedAnnotation >> styleInText: aBlRope [ 
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: Gt2DocumentConstants linkWithErrorColor
]
