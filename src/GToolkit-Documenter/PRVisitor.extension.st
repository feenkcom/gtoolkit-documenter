Extension { #name : 'PRVisitor' }

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGt2ChangesAnnotation: aGt2ChangesAnnotation [
	self visitAnnotation: aGt2ChangesAnnotation
]

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGt2ClassAnnotation: aGt2ClassAnnotation [ 
	self visitAnnotation: aGt2ClassAnnotation
]

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [ 
	self visitAnnotation: aGt2ExampleAnnotation
]

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGt2ExamplesAnnotation: aGt2ExamplesAnnotation [ 
	self visitAnnotation: aGt2ExamplesAnnotation
]

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [ 
	self visitAnnotation: aGt2IcebergFileAnnotation
]

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGt2XDocsAnnotation: aGt2XDocsAnnotation [ 
	self visitAnnotation: aGt2XDocsAnnotation
]

{ #category : '*GToolkit-Documenter' }
PRVisitor >> visitGtParametrizedExampleAnnotation: aGtParametrizedExampleAnnotation [
	self visitGt2ExampleAnnotation: aGtParametrizedExampleAnnotation
]
