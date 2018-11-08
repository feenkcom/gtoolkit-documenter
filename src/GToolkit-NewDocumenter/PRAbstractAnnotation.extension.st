Extension { #name : #PRAbstractAnnotation }

{ #category : #'*GToolkit-NewDocumenter' }
PRAbstractAnnotation >> styleInText: aBlRope [ 
	"Subclasses can add more styling"
	(aBlRope 
			from: self start 
			to: self stop)
				foreground: Gt2DocumentConstants subtleColor
]
