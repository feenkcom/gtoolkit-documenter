"
!Header 1

!!Header 2 

List:
# a
## a1
## a2
# b
# c

Paragraph ==monospace==
"
Class {
	#name : #GtOldPillarHighlightingParser,
	#superclass : #PRPillarGrammarOld,
	#instVars : [
		'fileReference',
		'workspace',
		'targetText',
		'scriptIndex'
	],
	#category : 'GToolkit-Documenter-Obsolete'
}

{ #category : #accessing }
GtOldPillarHighlightingParser class >> ignoredNames [
	^ super ignoredNames, #(fileReference targetText workspace scriptIndex)
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> annotatedParagraph [
	^ super annotatedParagraph token
	==> [ :t | 
		self targetText 
					attributes: { BrTextForegroundAttribute paint: Color red muchDarker }
					from: t start 
					to: t stop. ]
]

{ #category : #actions }
GtOldPillarHighlightingParser >> cleanWorkspace [
	"GtDocument may keep unused code snippet results in out.
	Extra results are removed."
	self workspace outs size = scriptIndex ifTrue: [ ^ self ].
	self workspace outs removeAllAfterIndex: scriptIndex.
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> figure [
	^ super figure
		==> [ :tokens | 
			"make sure that file is a picture"
			"we are doing a horrible hack here: we are creating the preview by hand if it needs to be expanded"
			self handleFigureWithTokens: tokens ]
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> figureMarkup [
	^ super figureMarkup token
]

{ #category : #accessing }
GtOldPillarHighlightingParser >> fileReference [
	^ fileReference
]

{ #category : #accessing }
GtOldPillarHighlightingParser >> fileReference: anObject [
	fileReference := anObject
]

{ #category : #handling }
GtOldPillarHighlightingParser >> handleFigureWithTokens: tokens [
	| attribute pictureFileReference fileNameWithoutPrefix |
	fileNameWithoutPrefix := tokens third.
	(fileNameWithoutPrefix beginsWith: 'file://')
		ifTrue: [ fileNameWithoutPrefix := fileNameWithoutPrefix
				copyFrom: 'file://' size + 1
				to: fileNameWithoutPrefix size ].
	pictureFileReference := self fileReference parent
		resolveString: fileNameWithoutPrefix.
	^ attribute := pictureFileReference exists
		ifTrue: [ "make sure that file is a picture"
			(pictureFileReference isFile
				and: [ pictureFileReference mimeTypes notNil
						and: [ pictureFileReference mimeTypes first matches: ZnMimeType imagePng ] ])
				ifTrue:
					[ | expandingAttribute attributesToAdd previewAttributeBlock previewAttribute |
					"we are doing a horrible hack here: we are creating the preview by hand if it needs to be expanded"
					previewAttributeBlock := [ | anImageForm |
						anImageForm := pictureFileReference
							binaryReadStreamDo: [ :stream | PNGReadWriter formFromStream: stream ].
						GtPillarPictureAttribute new image: anImageForm].
					expandingAttribute := BrTextExpandButtonAttribute new
						attributesCreatingBlock: previewAttributeBlock.
					attributesToAdd := OrderedCollection with: expandingAttribute.
					tokens fourth
						ifNotNil: [ :parameters | 
							(parameters
								anySatisfy: [ :p | p notEmpty and: [ p first = 'expanded' asArray ] ])
								ifTrue: [ previewAttribute := previewAttributeBlock value.
									expandingAttribute
										isExpanded: true;
										createdAttributes: {previewAttribute}.
									attributesToAdd add: previewAttribute ] ].
					self targetText
						attributes: attributesToAdd
						from: tokens first start
						to: tokens last stop ].
			self targetText
				attributes: {(BrTextForegroundAttribute paint: Color blue muchDarker)}
				from: tokens first start
				to: tokens last stop ]
		ifFalse: [ self targetText
				attributes: {(BrTextForegroundAttribute paint: Color red)}
				from: tokens first start
				to: tokens last stop ]
]

{ #category : #handling }
GtOldPillarHighlightingParser >> handleScriptWithTokens: tokens [
	| handlerClass handler codeSnippet scriptTokens type |
	scriptTokens := GtOldPillarScriptTokens new.
	self fileReference ifNotNil: [ 
		scriptTokens sourceFileReference: self fileReference ].
	scriptTokens tokens: tokens.
	scriptIndex := scriptIndex + 1.
	codeSnippet := GtOldCodeSnippetFinder new
		document: workspace;
		scriptIndex: scriptIndex;
		tokens: scriptTokens;
		find.
	type := GtOldPillarCodeSnippetDetector typeForScriptTokens: scriptTokens.
	handlerClass := type brickHandlerClass.
	handler := handlerClass new.
	handler
		tokens: scriptTokens;
		targetText: self targetText;
		sourceFile: self fileReference;
		codeSnippet: codeSnippet;
		handle.
	 ^ scriptTokens
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> header [
	^ super header token
	==> [ :t | 
		self targetText  
			attributes: { 
				BrFontSizeAttribute size: 20 - (t parsedValue first size)  }
			from: t start 
			to: t stop ]
]

{ #category : #initialization }
GtOldPillarHighlightingParser >> initialize [
	super initialize.
	scriptIndex := 0.
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> monospaceFormat [
	^ super monospaceFormat token 
	==> [ :token | 
		self targetText 
			attributes: { BrFontGenericFamilyAttribute monospace .  BrTextForegroundAttribute paint: Color darkGray }
			from: token start
			to: token stop ]
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> orderedList [
	^ super orderedList
	==> [ :tokens | 
		tokens withIndexDo: [ :each :index |
			self targetText 
				attributes: {
					BrTextAdornmentDynamicAttribute new 
						beAppend; 
						elementBlock: [ 
							| indexText |
							indexText := BrRopedText string: index asString.
							indexText attributes: { BrFontSizeAttribute size: 9 . BrTextForegroundAttribute paint: Color lightGray }.
							BlTextElement new text: indexText ] }
				from: each start
				to: each stop ] ]
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> orderedListItem [
	^ super orderedListItem
	==> [ :tokens | tokens first ]
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> orderedMarkup [
	^ super orderedMarkup token
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> parameterValueUntilNewline [
	"allow extra end markup"
	^ self parameterValueUntilParser: newline / (EndMarkups at: PRCodeblock) asParser
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> referenceFigure [
	^ super referenceFigure flatten
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> script [
	| endParser |
	endParser := ((EndMarkups at: PRCodeblock) asParser token , space star
		, lineEnd) ==> [ :t | t first ].	"newline asParser , "
	^ ((Markups at: PRCodeblock) asParser token , scriptParameters
		, endParser negate star token , endParser)
		==>
			[ :tokens | self handleScriptWithTokens: tokens ]
]

{ #category : #parsers }
GtOldPillarHighlightingParser >> scriptParameters [
	^ parametersUntilNewline , newline optional ==> [ :array | array first ]
	==> [ :array |
		(({ array first } asOrderedCollection addAll: array last; yourself)
			collect: [ :each |
				('' join: each first) -> (each second ifNotNil: [:second | '' join: second ]) ]) ]
]

{ #category : #accessing }
GtOldPillarHighlightingParser >> targetText [
	^ targetText
]

{ #category : #accessing }
GtOldPillarHighlightingParser >> targetText: anObject [
	targetText := anObject
]

{ #category : #accessing }
GtOldPillarHighlightingParser >> workspace [
	^ workspace
]

{ #category : #accessing }
GtOldPillarHighlightingParser >> workspace: anObject [
	workspace := anObject
]
