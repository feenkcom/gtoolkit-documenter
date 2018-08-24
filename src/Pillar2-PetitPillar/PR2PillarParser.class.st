Class {
	#name : #PR2PillarParser,
	#superclass : #PR2PillarGrammar,
	#category : 'Pillar2-PetitPillar'
}

{ #category : #'grammar - Anchor' }
PR2PillarParser >> anchor [
	"An anchor is just a line that begin with the character $@ and contains a text that we trim."

	^ super anchor ==> [ :array | PRAnchor named: array second ]
]

{ #category : #'grammar - Paragraph' }
PR2PillarParser >> annotatedParagraph [
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
PR2PillarParser >> annotation [
	^ super annotation ==> [ :array | 
			(array third withParametersInCollection: (array fourth ifNil: [ OrderedDictionary new ]))
				start: array first start;
				stop: array sixth stop ]
]

{ #category : #'grammar - Annotation' }
PR2PillarParser >> annotationParameters [
	^ super annotationParameters ==> [ :array | self parametersFrom: array ]
]

{ #category : #'grammar - Annotation' }
PR2PillarParser >> annotationTag [
	^ super annotationTag
		==> [ :array | | aTag |
				aTag := (self stringFrom: array).
				PRAbstractAnnotation 
					findClassAcceptingTag: aTag
					ifNone: [ PRSyntaxError signal: 'Pillar doesn''t support this tag : ''' , 
						aTag , ''' on his annotations.' ] ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> boldFormat [
	^ super boldFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> boldMarkup [
	^ super boldMarkup ==> [ :token | PRBoldFormat ]
]

{ #category : #'grammar - Text' }
PR2PillarParser >> commentedLine [
	^ super commentedLine ==> [ :array | PRCommentedLine content: array second ]
]

{ #category : #'grammar - Document' }
PR2PillarParser >> content [
	^ super content ==> [ :array | array second ifNil: [ {array first} ] ifNotNil: [ array ] ]
]

{ #category : #'grammar - Document' }
PR2PillarParser >> contents [
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
PR2PillarParser >> dataListItem [
	^ super dataListItem ==> [ :array | 
		| item |
		item := array second withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil ifTrue: [ 
			item addAll: (self listsParser parse: array fifth) ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> dataMarkup [
	^ super dataMarkup ==> [ :token | PRDataItem ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> dataSubListItem [
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
PR2PillarParser >> definitionList [
	^ super definitionList ==> [ :array | 
			(PRDefinitionList withAll: array second)
				start: array first start;
				stop: array last stop ]
]

{ #category : #'grammar - Document' }
PR2PillarParser >> document [
	"I build a PRDocument. I get a collection with all the children of the PRDocument and I dd them one by one."

	^ super document ==> [ :array | PRDocument withAll: array ]
]

{ #category : #'grammar - Paragraph' }
PR2PillarParser >> emptyParagraph [
	^ super emptyParagraph ==> [ :array | PREmptyParagraph new ]
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> figure [
	^ super figure
		==>
			[ :array | 
			| fig |
			fig := PRFigure reference: array third.
			fig addAll: (array second ifNil: [ {} ]).
			fig parameters: (array fourth ifNil: [ OrderedDictionary new ]).
			fig ]
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> figureAlias [
	^ super figureAlias
		==>
			[ :string | 
			string
				ifEmpty: [ {(PRText content: '')} ]
				ifNotEmpty: [ self parse: string startingAt: #oneLineContent ] ]
]

{ #category : #'from markdown' }
PR2PillarParser >> formatContent [
	^ super formatContent ==> [ :array | 
		(PRText content: (self stringFrom: array second))
			start: array first start;
			stop: array third stop ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> formatForArray: array [
	^ (array second withAll: (array third collect: [ :each | each second ]))
		start: array first start;
		stop: array last stop
]

{ #category : #'grammar - Header' }
PR2PillarParser >> header [
	"I create a PRHeader"

	^ super header ==> [ :array | 
		(PRHeader 
			withAll: (array third ifNil: [ {} ]) 
			level: array second size)
			start: array first start;
			stop: array last stop ]
]

{ #category : #'grammar - HorizontalRule' }
PR2PillarParser >> horizontalRule [
	^ super horizontalRule ==> [ :array | PRHorizontalRule new ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> italicFormat [
	^ super italicFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> italicMarkup [
	^ super italicMarkup ==> [ :token | PRItalicFormat ]
]

{ #category : #'grammar - Document' }
PR2PillarParser >> lineBreak [
	^ super lineBreak ==> [ :array | PRLineBreak new ]
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> link [
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
PR2PillarParser >> linkAlias [
	^ super linkAlias
		==>
			[ :string | 
			string
				ifEmpty: [ {(PRText content: '')} ]
				ifNotEmpty: [ self parse: string startingAt: #oneLineContent ] ]
]

{ #category : #helpers }
PR2PillarParser >> listsParser [
	"We cache the lists parser to be faster"
	"Attention: we refer to PRPillarParser explicitely here instead of using ==self== so that the PRPillarCompiled parser, if it exists, can work."
	^ PR2PillarParser newStartingAt: #lists
]

{ #category : #'grammar - Format' }
PR2PillarParser >> monospaceFormat [
	^ super monospaceFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> monospaceMarkup [
	^ super monospaceMarkup ==> [ :token | PRMonospaceFormat ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> orderedList [
	^ super orderedList ==> [ :array | 
			(PROrderedList withAll: array second)
				start: array first start;
				stop: array last stop ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> orderedListItem [
	^ super orderedListItem ==> [ :array | 
		| item |
		item := PRListItem withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil ifTrue: [ 
			item addAll: (self listsParser parse: array fifth) ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> orderedSubListItem [
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
PR2PillarParser >> paragraph [
	^ super paragraph ==> [ :array | PRParagraph withAll: array first]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterKeyUntilEndAnnotation [
	^ super parameterKeyUntilEndAnnotation ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterKeyUntilEndFigure [
	^ super parameterKeyUntilEndFigure ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterKeyUntilEndLink [
	^ super parameterKeyUntilEndLink ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterKeyUntilNewline [
	^ super parameterKeyUntilNewline ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterValueUntilEndAnnotation [
	^ super parameterValueUntilEndAnnotation ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterValueUntilEndFigure [
	^ super parameterValueUntilEndFigure ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterValueUntilEndLink [
	^ super parameterValueUntilEndLink ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Parameter' }
PR2PillarParser >> parameterValueUntilNewline [
	^ super parameterValueUntilNewline ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> parametersFigure [
	^ super parametersFigure ==> [ :array | self parametersFrom: array ]
]

{ #category : #'grammar - Paragraph' }
PR2PillarParser >> parametersFrom: array [
	| result |
	result := OrderedDictionary new.
	array first first
		ifNotEmpty:
			[ :string | 
			result at: string put: array first second.
			array second
				do:
					[ :each | each first ifNotEmpty: [ result at: each first put: each second ] ] ].
	^ result
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> parametersLink [
	^ super parametersLink ==> [ :array | self parametersFrom: array ]
]

{ #category : #helpers }
PR2PillarParser >> parse: anObject startingAt: aRule [
	^ (self class newStartingAt: aRule) parse: anObject
]

{ #category : #'grammar - Text' }
PR2PillarParser >> preformatedLine [
	^ super preformatedLine ==> [ :array | PRText content: array second ]
]

{ #category : #'grammar - Text' }
PR2PillarParser >> preformatedText [
	^ super preformatedText ==> [ :array | PRPreformatted withAll: array ]
]

{ #category : #'grammar - Raw' }
PR2PillarParser >> raw [
	^ super raw
		==>
			[ :array | 
			| type contentRaw |
			contentRaw := '' writeStream.
			contentRaw nextPutAll: array third.
			PRRaw content: contentRaw contents type: array second ]
]

{ #category : #'from markdown' }
PR2PillarParser >> referenceContent [
	^ super referenceContent ==> [ :array | PRText content: (self stringFrom: array) ]
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> referenceFigure [
	self flag: #todo. "We should maybe check for a :// inside the reference and maybe an extension."
	^ super referenceFigure ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Reference' }
PR2PillarParser >> referenceLink [
	^ super referenceLink ==> [ :array | self stringFrom: array ]
]

{ #category : #'grammar - Script' }
PR2PillarParser >> script [
	"I create a PRScript."

	^ super script ==> [ :array | 
		(PRCodeblock content: array fourth parameters: array third)
			start: array first start;
			stop: array last stop ]
]

{ #category : #'grammar - Script' }
PR2PillarParser >> scriptParameters [
	^ super scriptParameters ==> [ :array | self parametersFrom: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> strikethroughFormat [
	^ super strikethroughFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> strikethroughMarkup [
	^ super strikethroughMarkup ==> [ :token | PRStrikethroughFormat ]
]

{ #category : #helpers }
PR2PillarParser >> stringFrom: characterArray [
	^ String streamContents: [ :stream | characterArray do: [ :character | stream nextPut: character ] ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> subscriptFormat [
	^ super subscriptFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> subscriptMarkup [
	^ super subscriptMarkup ==> [ :token | PRSubscriptFormat ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> superscriptFormat [
	^ super superscriptFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> superscriptMarkup [
	^ super superscriptMarkup ==> [ :token | PRSuperscriptFormat ]
]

{ #category : #'grammar - Table' }
PR2PillarParser >> table [
	^ super table ==> [ :array | PRTable withAll: array ]
]

{ #category : #'grammar - Table' }
PR2PillarParser >> tableCell [
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
PR2PillarParser >> tableCenterMarkup [
	^ super tableCenterMarkup ==> [ :token | #center ]
]

{ #category : #'grammar - Table' }
PR2PillarParser >> tableHeadingMarkup [
	^ super tableHeadingMarkup ==> [ :token | true ]
]

{ #category : #'grammar - Table' }
PR2PillarParser >> tableLeftMarkup [
	^ super tableLeftMarkup ==> [ :token | #left ]
]

{ #category : #'grammar - Table' }
PR2PillarParser >> tableMarkups [
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
PR2PillarParser >> tableRightMarkup [
	^ super tableRightMarkup ==> [ :token | #right ]
]

{ #category : #'grammar - Table' }
PR2PillarParser >> tableRow [
	^ super tableRow
		==> [ :array | 
			| result |
			result := PRTableRow new.
			array first do: [ :cell | result add: cell ].
			result ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> termListItem [
	^ super termListItem ==> [ :array | 
		| item |
		item := array second withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil ifTrue: [ 
			item addAll: (self listsParser parse: array fifth) ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> termMarkup [
	^ super termMarkup ==> [ :token | PRTermItem ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> termSubListItem [
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
PR2PillarParser >> text [
	"A text is a PRText with a string that contains any character inside."

	^ super text ==> [ :array | 
			(PRText content: (self stringFrom: array second))
				start: array first start;
				stop: array third stop ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> underlineFormat [
	^ super underlineFormat ==> [ :array | self formatForArray: array ]
]

{ #category : #'grammar - Format' }
PR2PillarParser >> underlineMarkup [
	^ super underlineMarkup ==> [ :token | PRUnderlineFormat ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> unorderedList [
	^ super unorderedList ==> [ :array | 
			(PRUnorderedList withAll: array second)
				start: array first start;
				stop: array last stop ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> unorderedListItem [
	^ super unorderedListItem ==> [ :array | 
		| item |
		item := PRListItem withAll: (array third ifNil: [ {} ]).
		item addAll: array fourth.
		array fifth isNotNil
			ifTrue:
				[ item addAll: (self listsParser parse: array fifth) ].
		item start: array first start; stop: array last stop.
		item ]
]

{ #category : #'grammar - List' }
PR2PillarParser >> unorderedSubListItem [
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
