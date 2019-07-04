Extension { #name : #GtPhlowProtoView }

{ #category : #'*GToolkit-Documenter' }
GtPhlowProtoView >> document [
	^ GtPhlowDocumentView new 
		originalView: self;
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect)
]
