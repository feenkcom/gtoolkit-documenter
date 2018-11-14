Extension { #name : #PRHTMLWriter }

{ #category : #'*GToolkit-Documenter' }
PRHTMLWriter >> visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation [
	GtPillarExampleAnnotationHtmlWriter new writer: self; node: aGtPillarExampleAnnotation; write
]
