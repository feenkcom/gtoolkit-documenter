Extension { #name : #PRHTMLWriter }

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> gtWriteExampleCode: aGt2ExampleAnnotation [ 
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
											self writeCounterForScript: aGt2ExampleAnnotation ].
									aGt2ExampleAnnotation hasCaption
										ifTrue: [ self visitAll: aGt2ExampleAnnotation caption children ] ] ].
	canvas newLine
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> gtWriteExampleResult: aGt2ExampleAnnotation [ 
	| aFigure aFigureReference |
	aFigure := PRFigure new.
	aFigure label: 'figure-' , aGt2ExampleAnnotation methodName.
	aFigure add: (PRText content: 'Result of ' , aGt2ExampleAnnotation methodName).
	aFigureReference := self configuration gtDataWriter exampleResultReferenceFor: aGt2ExampleAnnotation.
	aFigure reference: aFigureReference.
	self visitFigure: aFigure.
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ChangesAnnotation: aGt2ChangesAnnotation [
	| aContent |
	aGt2ChangesAnnotation gtDocument: self configuration gtDocument.
	aContent := aGt2ChangesAnnotation cachedChanges tutorialStateRope asString.
	canvas tag
		name: 'figure';
		parameterAt: 'class' put: 'changes';
		with: [ 
					canvas tag
						name: 'pre';
						with: [ canvas lines: aContent ].
				].
	canvas newLine
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ClassAnnotation: aGt2ClassAnnotation [ 
	canvas tag 
		name: 'code';
		with: aGt2ClassAnnotation referencedClass name
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	aGt2ExampleAnnotation isMethodDefined ifFalse: [ ^ self ].
	aGt2ExampleAnnotation noCode ifFalse: [ self gtWriteExampleCode: aGt2ExampleAnnotation ].
	aGt2ExampleAnnotation isPreviewDefined ifFalse: [ ^ self ].
	self gtWriteExampleResult: aGt2ExampleAnnotation.
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2IcebergFileAnnotation: aGt2IcebergFileAnnotation [ 
	| aHref |
	aGt2IcebergFileAnnotation isReferenceDefined ifFalse: [ ^ self ]. 
	aHref := GtFileUtilityConstants localGtDirectoryName, '/', aGt2IcebergFileAnnotation path.
	canvas tag
		name: 'a';
		parameterAt: 'href' put: aHref;
		with: [ canvas nextPutAll: aHref ].
]

{ #category : #'*GToolkit-NewDocumenter-XDoc' }
PRHTMLWriter >> visitGt2MethodAnnotation: aGt2MethodAnnotation [ 
	canvas tag 
		name: 'code';
		with: aGt2MethodAnnotation referencedMethod fullName
]
