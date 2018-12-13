Extension { #name : #PRHTMLWriter }

{ #category : #'*GToolkit-NewDocumenter' }
PRHTMLWriter >> visitGt2ClassAnnotation: aGt2ClassAnnotation [ 
	canvas tag 
		name: 'code';
		with: aGt2ClassAnnotation referencedClass name
]

{ #category : #'*GToolkit-NewDocumenter' }
PRHTMLWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	canvas tag
		name: 'figure';
		parameterAt: 'class' put: 'gtexample-src';
		with: [ 
					canvas tag
						name: 'pre';
						with: [ 
									| code language |
									code := canvas tag
										name: 'code';
										yourself.
									language := PRSmalltalkScriptLanguage default.
									language isSyntaxHighlightingPossible
										ifTrue: [ code parameterAt: 'class' put: language printString ].
									code with: [ aGt2ExampleAnnotation isMethodDefined 
										ifTrue: [ canvas lines: aGt2ExampleAnnotation methodDefinition sourceCode ]
										ifFalse: [ canvas lines: aGt2ExampleAnnotation methodDefinition printString ] ] ].
					canvas tag
						name: 'figcaption';
						with: [ 
									aGt2ExampleAnnotation hasLabel
										ifTrue: [ 
											self createAnchorWith: aGt2ExampleAnnotation label.
											"self writer writeCounterForScript: aGt2ExampleAnnotation" ].
									aGt2ExampleAnnotation hasCaption
										ifTrue: [ self visitAll: aGt2ExampleAnnotation caption children ] ] ].
	canvas newLine
]

{ #category : #'*GToolkit-NewDocumenter' }
PRHTMLWriter >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [ 
	self flag: 'ignore for now'.
	super visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation
]

{ #category : #'*GToolkit-NewDocumenter' }
PRHTMLWriter >> visitGt2MethodAnnotation: aGt2MethodAnnotation [ 
	canvas tag 
		name: 'code';
		with: aGt2MethodAnnotation referencedMethod fullName
]

{ #category : #'*GToolkit-NewDocumenter' }
PRHTMLWriter >> writeExampleAnnotation: aGt2ExampleAnnotation toFile: aFileReference [ 
	| anExampleReturnValue aContainer aView |
	
	anExampleReturnValue := aGt2ExampleAnnotation methodDefinition compiledMethod gtExample returnValue.
	
	aContainer := GtPillarExporterContainerElement new.
	"recommended size"
	aContainer size: 500@300.

	aView := GtPhlowView empty 
		on: anExampleReturnValue 
		perform: aGt2ExampleAnnotation previewShowSelector.
	aView asElementDo: [ :anElement | aContainer addChild: anElement ].
	
	aContainer forceLayout.

	aFileReference ensureDelete.
	BlSvgExporter new element: aContainer; fileName: aFileReference; export.

]
