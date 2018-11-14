Extension { #name : #PRHTMLWriter }

{ #category : #'*GToolkit-Documenter' }
PRHTMLWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	self visitGtPillarExampleAnnotation: aGt2ExampleAnnotation
]

{ #category : #'*GToolkit-Documenter' }
PRHTMLWriter >> visitGtPillarExampleAnnotation: aGtPillarExampleAnnotation [
	GtPillarExampleAnnotationHtmlWriter new writer: self; node: aGtPillarExampleAnnotation; write
]
