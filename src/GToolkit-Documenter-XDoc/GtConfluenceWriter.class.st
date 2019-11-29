Class {
	#name : #GtConfluenceWriter,
	#superclass : #PRHTMLWriter,
	#category : #'GToolkit-Documenter-XDoc-Confluence'
}

{ #category : #private }
GtConfluenceWriter >> exportImgFor: aFigure [
	canvas tag
		name: 'ac:image';
		parameterAt: 'ac:height' put: '250';
		with: [
			canvas emptyTag
				name: 'ri:attachment';
				parameterAt: 'ri:filename' put: 'file.png';
				closeTag.
		].
]

{ #category : #'as yet unclassified' }
GtConfluenceWriter >> gtWriteSourceCodeForEntity: anEntityName with: aSourceCode [
	canvas tag
		name: 'span';
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
	aGt2ExampleAnnotation noCode ifFalse: [ self gtWriteExampleCode: aGt2ExampleAnnotation ].
	aGt2ExampleAnnotation canBeExecuted ifFalse: [ ^ self ].
	self gtWriteExampleResult: aGt2ExampleAnnotation.
]

{ #category : #'visiting-document' }
GtConfluenceWriter >> visitLineBreak: aLineBreak [
	canvas linebreak.
]
