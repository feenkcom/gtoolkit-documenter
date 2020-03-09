"
This is a hack that partially fixes this issue: *https://github.com/feenkcom/gtoolkit/issues/700*.

"
Class {
	#name : #GtDocumenterParser,
	#superclass : #PRPillarGrammar,
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #parsing }
GtDocumenterParser class >> parse: aStream [
	^ self new parse: aStream
]

{ #category : #'grammar - Anchor' }
GtDocumenterParser >> anchor [
	"An anchor is just a line that begin with the character $@ and contains a text that we trim."

	^ super anchor ==> [ :array | PRAnchor named: array second ]
]

{ #category : #'grammar - Paragraph' }
GtDocumenterParser >> annotatedParagraph [
	^ super annotatedParagraph
		==> [ :array | 
				(PRAnnotatedParagraph 
					withAll: (array fourth
						ifNil: [ {} ] 
						ifNotNil: [ :elem | elem second ]) 
					annotation: array third)
						start: array first start;
						stop: array last stop ]
]

{ #category : #'grammar - Annotation' }
GtDocumenterParser >> annotation [
	^ super annotation ==> [ :array | 
			(array third withParameters: (array fourth ifNil: [ PRParameters new ]))
				start: array first start;
				stop: array sixth stop ]
]

{ #category : #'grammar - Annotation' }
GtDocumenterParser >> annotationParameters [
	^ super annotationParameters ==> [ :array | self parametersObjectFrom: array ]
]

{ #category : #'grammar - Annotation' }
GtDocumenterParser >> annotationTag [
	^ super annotationTag
		==> [ :array | | aTagName |
				aTagName := self stringFrom: array.
				PRAbstractAnnotation 
					findClassAcceptingTag: aTagName
					ifNone: [ PRValidation strategy missingAnnotationSupport: aTagName ] ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> boldFormat [
	^ super boldFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> boldMarkup [
	^ super boldMarkup ==> [ :token | PRBoldFormat ]
]

{ #category : #'grammar - Text' }
GtDocumenterParser >> commentedLine [
	^ super commentedLine ==> [ :array | 
		(PRCommentedLine content: array third)
			start: array first start;
			stop: array last stop ]
]

{ #category : #'grammar - Document' }
GtDocumenterParser >> content [
	^ super content ==> [ :array | array second ifNil: [ {array first} ] ifNotNil: [ array ] ]
]

{ #category : #'grammar - Document' }
GtDocumenterParser >> contents [
	^ super contents
		==> [ :array | 
			| result |
			result := OrderedCollection new.
			array
				do: [ :each | 
					result addAll: each first.
					each size = 2
						ifTrue: [ result add: each second ] ].
			result ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> dataListItem [
	^ super dataListItem ==> [ :array | 
		| item |
		item := array second withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil ifTrue: [ "ignore sub-items for now"
				| aNode |
				aNode := PRText new
					text: array fifth;
					start: array first start;
					stop: array first start + array fifth size.
				item add: aNode ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> dataMarkup [
	^ super dataMarkup ==> [ :token | PRDataItem ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> dataSubListItem [
	^ super dataSubListItem
		==>
			[ :array | 
			| result |
			result := '' writeStream.
			array
				do: [ :elem | 
					elem isString
						ifTrue: [ result nextPutAll: elem ]
						ifFalse: [ result nextPutAll: elem second ] ].
			result contents ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> definitionList [
	^ super definitionList ==> [ :array | 
			(PRDefinitionList withAll: array second)
				start: array first start;
				stop: array last stop ]
]

{ #category : #'grammar - Document' }
GtDocumenterParser >> document [
	"I build a PRDocument. I get a collection with all the children of the PRDocument and I dd them one by one."

	^ super document ==> [ :array | PRDocument withAll: array ]
]

{ #category : #'grammar - Paragraph' }
GtDocumenterParser >> emptyParagraph [
	^ super emptyParagraph ==> [ :array |
		PREmptyParagraph new start: array first start; stop: array third stop ]
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> figure [
	^ super figure ==> [ :array | 
			| fig |
			fig := PRFigure reference: array fourth.
			fig addAll: (array third ifNil: [ {} ]).
			fig parameters: (array fifth ifNil: [ OrderedDictionary new ]).
			fig start: array first start; stop: array last stop.
			fig ]
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> figureAlias [
	^ super figureAlias ==> [ :anArray | 
			anArray second
				ifEmpty: [ { (PRText content: '') start: anArray first start; stop: anArray first start } ]
				ifNotEmpty: [ 
					| aCollection |
					aCollection := (self parse: anArray second startingAt: #oneLineContent).
					aCollection do: [ :each | 
						each start: each start + anArray first start - 1.
						each stop: each stop + anArray first start - 1 ] ] ]
]

{ #category : #'from markdown' }
GtDocumenterParser >> formatContent [
	^ super formatContent ==> [ :array | 
		(PRText content: (self stringFrom: array second))
			start: array first start;
			stop: array third stop ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> formatForArray: array [
	^ (array second withAll: (array third collect: [ :each | each second ]))
		start: array first start;
		stop: array last stop
]

{ #category : #'grammar - Header' }
GtDocumenterParser >> header [
	"I create a PRHeader"

	^ super header ==> [ :array | 
		(PRHeader 
			withAll: (array third ifNil: [ {} ]) 
			level: array second size)
			start: array first start;
			stop: array last stop ]
]

{ #category : #'grammar - HorizontalRule' }
GtDocumenterParser >> horizontalRule [
	^ super horizontalRule ==> [ :array | PRHorizontalRule new ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> italicFormat [
	^ super italicFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> italicMarkup [
	^ super italicMarkup ==> [ :token | PRItalicFormat ]
]

{ #category : #'grammar - Document' }
GtDocumenterParser >> lineBreak [
	^ super lineBreak ==> [ :array | PRLineBreak new ]
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> link [
	^ super link
		==>
			[ :array | 
			| linkRes |
			linkRes := PRLink fromReference: array fourth.
			array third ifNotNil: [ :aliasChildren | linkRes addAll: aliasChildren ].
			linkRes parameters: (array fifth ifNil: [ OrderedDictionary new ]).
			linkRes start: array first start; stop: array last stop.
			linkRes ]
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> linkAlias [
	^ super linkAlias ==> [ :anArray | 
			anArray second
				ifEmpty: [ { (PRText content: '') start: anArray first start; stop: anArray first start } ]
				ifNotEmpty: [ 
					| aCollection |
					aCollection := (self parse: anArray second startingAt: #oneLineContent).
					aCollection do: [ :each | 
						each start: each start + anArray first start - 1.
						each stop: each stop + anArray first start - 1 ] ] ]
]

{ #category : #helpers }
GtDocumenterParser >> listsParser [
	"We cache the lists parser to be faster"
	"Attention: we refer to PRPillarParser explicitely here instead of using ==self== so that the PRPillarCompiled parser, if it exists, can work."
	^ self 
		propertyAt: #listsParser 
		ifAbsentPut: [ (PRPillarParser newStartingAt: #lists) optimize ]
]

{ #category : #helpers }
GtDocumenterParser >> literalFrom: characterArray [
	^ PRParserUtility convertToPharoObject: (self stringFrom: characterArray)
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> monospaceFormat [
	^ super monospaceFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> monospaceMarkup [
	^ super monospaceMarkup ==> [ :token | PRMonospaceFormat ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> orderedList [
	^ super orderedList ==> [ :array | 
			(PROrderedList withAll: array second)
				start: array first start;
				stop: array last stop ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> orderedListItem [
	^ super orderedListItem ==> [ :array | 
		| item |
		item := PRListItem withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil ifTrue: [ "ignore sub-items for now"
				| aNode |
				aNode := PRText new
					text: array fifth;
					start: array first start;
					stop: array first start + array fifth size.
				item add: aNode ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> orderedSubListItem [
	^ super orderedSubListItem
		==>
			[ :array | 
			| result |
			result := '' writeStream.
			array
				do: [ :elem | 
					elem isString
						ifTrue: [ result nextPutAll: elem ]
						ifFalse: [ result nextPutAll: elem second ] ].
			result contents ]
]

{ #category : #'grammar - Paragraph' }
GtDocumenterParser >> paragraph [
	^ super paragraph ==> [ :array | 
		(PRParagraph withAll: array second)
			start: array first start;
			stop: array last stop ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterFrom: array [
	^ (PRParameter 
			keyNode: array second 
			valueNode: (array third ifNil: [ PRParserUtility newDefaultParameterValue ]))
		start: array first start;
		stop: array last stop
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterKeyFrom: array [
	^ (PRParameterKey named: (self stringFrom: array second))
		start: array first start;
		stop: array last stop
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterKeyUntilEndAnnotation [
	^ super parameterKeyUntilEndAnnotation ==> [ :array | self parameterKeyFrom: array ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterKeyUntilEndFigure [
	^ super parameterKeyUntilEndFigure ==> [ :array | self stringFrom: array second ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterKeyUntilEndLink [
	^ super parameterKeyUntilEndLink ==> [ :array | self stringFrom: array second ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterKeyUntilNewline [
	^ super parameterKeyUntilNewline ==> [ :array | self stringFrom: array second ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterUntilEndAnnotation [
	^ super parameterUntilEndAnnotation ==>
			[ :array | self parameterFrom: array ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterUntilNewline [
	^ super parameterUntilNewline "==>
			[ :array | self parameterFrom: array ]"
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterValueFrom: array [
	^ (PRParameterValue value: (self literalFrom: array third))
		start: array second start;
		stop: array last stop
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterValueUntilEndAnnotation [
	^ super parameterValueUntilEndAnnotation ==> [ :array | self parameterValueFrom: array ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterValueUntilEndFigure [
	^ super parameterValueUntilEndFigure ==> [ :array | self stringFrom: array third ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterValueUntilEndLink [
	^ super parameterValueUntilEndLink ==> [ :array | self stringFrom: array third ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parameterValueUntilNewline [
	^ super parameterValueUntilNewline ==> [ :array | self stringFrom: array third ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parametersConvertToPharoObject: aString [
	"Convert if possible the aString argument into a Pharo object, we also replace nil by true"
	"We assume that aString represents only one possible value"

	| parsed |
	aString ifNil: [ ^ true ]. 
	"This is for the case where for example we have [[[foo, its value is nil and it should be true"
	parsed := (RBParser parseFaultyExpression: aString).

	^ parsed isLiteralNode 	
		ifTrue: [ parsed value]
		ifFalse: [ aString ]

	"^ [(Object readFrom: aString)
			ifNil: [ aString trimBoth ]
		ifNotNil: [ :e | e ]
		] on: Exception  do: [ :e | PRSyntaxError signal: aString, ' is not a valid value'
			aString ]"
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> parametersFigure [
	^ super parametersFigure ==> [ :array | self parametersFrom: array ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parametersFrom: array [
	| result |
	result := OrderedDictionary new.
	
	array first first
		ifNotEmpty:
			[ :string | 
			result at: string trimBoth put: (self parametersConvertToPharoObject: array first second).
			array second
				do:
					[ :each | each first ifNotEmpty: [ result at: each first trimBoth put: (self parametersConvertToPharoObject: each second) ] ] ].
	^ result
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> parametersLink [
	^ super parametersLink ==> [ :array | self parametersFrom: array ]
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parametersObjectFrom: array [
	^ (PRParameters with: array fourth first withAll: array fourth second)
			start: array third start;
			stop: array fifth stop
]

{ #category : #'grammar - Parameter' }
GtDocumenterParser >> parametersUntilNewline [
	^ super parametersUntilNewline
]

{ #category : #helpers }
GtDocumenterParser >> parse: anObject startingAt: aRule [
	^ (self class newStartingAt: aRule) parse: anObject
]

{ #category : #'grammar - Text' }
GtDocumenterParser >> preformatedLine [
	^ super preformatedLine ==> [ :array | PRText content: array second ]
]

{ #category : #'grammar - Text' }
GtDocumenterParser >> preformatedText [
	^ super preformatedText ==> [ :array | PRPreformatted withAll: array ]
]

{ #category : #'grammar - Raw' }
GtDocumenterParser >> raw [
	^ super raw
		==>
			[ :array | 
			| type contentRaw |
			contentRaw := '' writeStream.
			contentRaw nextPutAll: array third.
			PRRaw content: contentRaw contents type: array second ]
]

{ #category : #'from markdown' }
GtDocumenterParser >> referenceContent [
	^ super referenceContent ==> [ :array | PRText content: (self stringFrom: array) ]
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> referenceFigure [
	self flag: #todo. "We should maybe check for a :// inside the reference and maybe an extension."
	^ super referenceFigure ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Reference' }
GtDocumenterParser >> referenceLink [
	^ super referenceLink ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Script' }
GtDocumenterParser >> script [
	"I create a PRScript."

	^ super script ==> [ :array | 
		(PRCodeblock content: array fourth parameters: array third)
			start: array first start;
			stop: array last stop ]
]

{ #category : #'grammar - Script' }
GtDocumenterParser >> scriptParameters [
	^ super scriptParameters ==> [ :array | self parametersFrom: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> strikethroughFormat [
	^ super strikethroughFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> strikethroughMarkup [
	^ super strikethroughMarkup ==> [ :token | PRStrikethroughFormat ]
]

{ #category : #helpers }
GtDocumenterParser >> stringFrom: characterArray [
	^ String streamContents: [ :stream | characterArray do: [ :character | stream nextPut: character ] ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> subscriptFormat [
	^ super subscriptFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> subscriptMarkup [
	^ super subscriptMarkup ==> [ :token | PRSubscriptFormat ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> superscriptFormat [
	^ super superscriptFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> superscriptMarkup [
	^ super superscriptMarkup ==> [ :token | PRSuperscriptFormat ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> table [
	^ super table ==> [ :array | PRTable withAll: array ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableCell [
	^ super tableCell
		==>
			[ :array | 
			PRTableCell
				align: array first first
				heading: array first second
				withAll:
					(array second trim
						ifEmpty: [ Array new ]
						ifNotEmpty:
							[ :string | self parse: string startingAt: #oneLineContent ]) ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableCenterMarkup [
	^ super tableCenterMarkup ==> [ :token | #center ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableHeadingMarkup [
	^ super tableHeadingMarkup ==> [ :token | true ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableLeftMarkup [
	^ super tableLeftMarkup ==> [ :token | #left ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableMarkups [
	^ super tableMarkups
		==> [ :array | 
			| result |
			result := Array ofSize: 2.
			result at: 2 put: (array second = true or: [ array third = true ]).
			result
				at: 1
				put:
					(array second isSymbol
						ifTrue: [ array second ]
						ifFalse: [ 
							array third isSymbol
								ifTrue: [ array third ] ]).
			result ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableRightMarkup [
	^ super tableRightMarkup ==> [ :token | #right ]
]

{ #category : #'grammar - Table' }
GtDocumenterParser >> tableRow [
	^ super tableRow
		==> [ :array | 
			| result |
			result := PRTableRow new.
			array first do: [ :cell | result add: cell ].
			result ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> termListItem [
	^ super termListItem ==> [ :array | 
		| item |
		item := array second withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil ifTrue: [ "ignore sub-items for now"
				| aNode |
				aNode := PRText new
					text: array fifth;
					start: array first start;
					stop: array first start + array fifth size.
				item add: aNode ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> termMarkup [
	^ super termMarkup ==> [ :token | PRTermItem ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> termSubListItem [
	^ super termSubListItem
		==>
			[ :array | 
			| result |
			result := '' writeStream.
			array
				do: [ :elem | 
					elem isString
						ifTrue: [ result nextPutAll: elem ]
						ifFalse: [ result nextPutAll: elem second ] ].
			result contents ]
]

{ #category : #'grammar - Text' }
GtDocumenterParser >> text [
	"A text is a PRText with a string that contains any character inside."

	^ super text ==> [ :array | 
			(PRText content: (self stringFrom: array second))
				start: array first start;
				stop: array third start - 1 ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> underlineFormat [
	^ super underlineFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
GtDocumenterParser >> underlineMarkup [
	^ super underlineMarkup ==> [ :token | PRUnderlineFormat ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> unorderedList [
	^ super unorderedList ==> [ :array | 
			(PRUnorderedList withAll: array second)
				start: array first start;
				stop: array last stop ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> unorderedListItem [
	^ super unorderedListItem ==> [ :array | 
		| item |
		item := PRListItem withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil
			ifTrue:
				[ "ignore sub-items for now"
				| aNode |
				aNode := PRText new
					text: array fifth;
					start: array first start;
					stop: array first start + array fifth size.
				item add: aNode ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
GtDocumenterParser >> unorderedSubListItem [
	^ super unorderedSubListItem
		==>
			[ :array | 
			| result |
			result := '' writeStream.
			array
				do: [ :elem | 
					elem isString
						ifTrue: [ result nextPutAll: elem ]
						ifFalse: [ result nextPutAll: elem second ] ].
			result contents ]
]
