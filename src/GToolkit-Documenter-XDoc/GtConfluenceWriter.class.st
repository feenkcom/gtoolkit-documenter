Class {
	#name : #GtConfluenceWriter,
	#superclass : #PRHTMLWriter,
	#category : #'GToolkit-Documenter-XDoc-Confluence'
}

{ #category : #private }
GtConfluenceWriter >> exportImgFor: aFigure [
	| height label |

	aFigure parameters at: #height ifPresent: [:value | height := value ] ifAbsent: [ height := 200].
	aFigure parameters at: #label ifPresent: [:value | label := value ] ifAbsent: [ label := ''].

	canvas linebreak.
	canvas tag
		name: 'ac:image';
		parameterAt: 'ac:height' put: (height asString);
		parameterAt: 'ac:title' put: label;
		with: [
			canvas emptyTag
				name: 'ri:attachment';
				parameterAt: 'ri:filename' put: (aFigure localFileOrExternalReference) asFileReference basename;
				closeTag.
		].
	canvas linebreak.
]

{ #category : #'as yet unclassified' }
GtConfluenceWriter >> gtWriteExampleResult: aGt2ExampleAnnotation [ 
	| aFigure aFigureReference |
	aFigure := PRFigure new.
	aFigure label: ('Result of ' , aGt2ExampleAnnotation referencedExample selector).
	aFigureReference := self configuration gtDataWriter exampleResultReferenceFor: aGt2ExampleAnnotation.
	aFigure reference: aFigureReference.
	aFigure parameterAt: #height put: aGt2ExampleAnnotation previewHeight.
	self visitFigure: aFigure.
]

{ #category : #'as yet unclassified' }
GtConfluenceWriter >> gtWriteSourceCodeForEntity: anEntityName with: aSourceCode [
	canvas tag
		name: 'em';
		with: [ canvas nextPutAll: anEntityName ].
"	| uniqueId language code |
	uniqueId := 	self configuration gtUniqueIdGenerator next printString.
	aSourceCode 
		ifNil: [ 
			canvas tag
				name: 'span';
				with: [ canvas nextPutAll: anEntityName ].
		 ];
		ifNotNil: [ 
			canvas tag
				name: 'span';
				parameterAt: 'class' put: 'sourceCode';
				with: [ 
					canvas tag
						name: 'a';
						with: [ canvas nextPutAll: anEntityName ].
						canvas tag
							name: 'span';
							parameterAt: 'id' put: uniqueId;
							parameterAt: 'class' put: 'codeBlock';
							with: [
								language := PRSmalltalkScriptLanguage default.
								code := canvas tag
									name: 'code';
									yourself.
								language := PRSmalltalkScriptLanguage default.
								language isSyntaxHighlightingPossible
									ifTrue: [ code parameterAt: 'class' put: language printString ].
								code with: [ 
									canvas newLine.
									canvas lines: aSourceCode.
									canvas newLine.
								].
							].
					].
		 ]."
]

{ #category : #'visiting-document' }
GtConfluenceWriter >> visitExternalLink: anExternalLink [
	canvas tag
		name: 'a';
		parameterAt: 'href' put: (anExternalLink localFileOrExternalReference replaceAllRegex: '&' with: '&amp;');
		with: anExternalLink alias.
]

{ #category : #visiting }
GtConfluenceWriter >> visitGt2ExampleAnnotation: aGt2ExampleAnnotation [
	aGt2ExampleAnnotation gtDocument: self configuration gtDocument.
	aGt2ExampleAnnotation isMethodDefined ifFalse: [ ^ self ].
	aGt2ExampleAnnotation isLabelParameterValueDefined ifTrue: [ 
		canvas tag
			name: 'code';
			with: aGt2ExampleAnnotation labelText.
	].
	aGt2ExampleAnnotation noCode ifFalse: [
		aGt2ExampleAnnotation expandedParameterValue ifTrue: [ self gtWriteExampleCode: aGt2ExampleAnnotation ].
	].
	aGt2ExampleAnnotation canBeExecuted ifFalse: [ ^ self ].
	aGt2ExampleAnnotation isLabelParameterValueDefined ifFalse: [ 
		self gtWriteExampleResult: aGt2ExampleAnnotation.
	].
]

{ #category : #visiting }
GtConfluenceWriter >> visitGt2MethodAnnotation: aGt2MethodAnnotation [	
	| name |
	aGt2MethodAnnotation isLabelParameterValueDefined 
		ifTrue: [ name := aGt2MethodAnnotation labelText ]
		ifFalse: [ name := aGt2MethodAnnotation referencedMethod name ].
	self gtWriteSourceCodeForEntity: name with: (aGt2MethodAnnotation referencedMethod sourceCode). 
	
]

{ #category : #'visiting-document' }
GtConfluenceWriter >> visitLineBreak: aLineBreak [
	canvas linebreak.
]
