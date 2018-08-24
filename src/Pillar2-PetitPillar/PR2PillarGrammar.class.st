Class {
	#name : #PR2PillarGrammar,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'document',
		'newline',
		'lineEnd',
		'elementsAtLineBeginning',
		'paragraph',
		'content',
		'text',
		'otherContent',
		'escapedCharacter',
		'lineBreak',
		'contents',
		'commentedLine',
		'annotation',
		'format',
		'header',
		'elementWithNewline',
		'emptyParagraph',
		'oneLineContent',
		'anchor',
		'preformatedText',
		'preformatedLine',
		'horizontalRule',
		'annotatedParagraph',
		'list',
		'unorderedList',
		'orderedList',
		'definitionList',
		'listMarkup',
		'subList',
		'lists',
		'table',
		'tableRow',
		'tableMarkups',
		'tableAlignMarkup',
		'tableHeadingMarkup',
		'tableCell',
		'tableCenterMarkup',
		'tableLeftMarkup',
		'tableRightMarkup',
		'script',
		'reference',
		'link',
		'figure',
		'raw',
		'orderedListItem',
		'unorderedListItem',
		'termListItem',
		'dataListItem',
		'dataBasicListItem',
		'orderedBasicListItem',
		'termBasicListItem',
		'unorderedBasicListItem',
		'dataSubListItem',
		'orderedSubListItem',
		'termSubListItem',
		'unorderedSubListItem',
		'monospaceFormat',
		'boldFormat',
		'italicFormat',
		'underlineFormat',
		'strikethroughFormat',
		'subscriptFormat',
		'superscriptFormat',
		'boldMarkup',
		'monospaceMarkup',
		'italicMarkup',
		'strikethroughMarkup',
		'subscriptMarkup',
		'superscriptMarkup',
		'underlineMarkup',
		'annotationEndMarkup',
		'dataMarkup',
		'orderedMarkup',
		'termMarkup',
		'unorderedMarkup',
		'rawEndMarkup',
		'figureMarkup',
		'linkMarkup',
		'scriptParameters',
		'parameterMarkup',
		'parameterValueMarkup',
		'space',
		'referenceAliasMarkup',
		'formatContent',
		'figureReference',
		'parametersUntilNewline',
		'parameterUntilNewline',
		'parameterValueUntilNewline',
		'parameterKeyUntilNewline',
		'parametersUntilEndAnnotation',
		'parameterUntilEndAnnotation',
		'annotationMarkupSeparator',
		'parameterKeyUntilEndAnnotation',
		'parameterValueUntilEndAnnotation',
		'annotationTag',
		'annotationParameters',
		'referenceFigure',
		'parametersFigure',
		'parametersUntilEndFigure',
		'parameterUntilEndFigure',
		'parameterKeyUntilEndFigure',
		'parameterValueUntilEndFigure',
		'referenceLink',
		'parameterKeyUntilEndLink',
		'parameterValueUntilEndLink',
		'parameterUntilEndLink',
		'parametersUntilEndLink',
		'parametersLink',
		'rawTypeMarkup',
		'rawType',
		'specialReferenceMarkups',
		'specialFormatMarkups',
		'referenceContent',
		'linkAlias',
		'figureAlias',
		'epsilonToken'
	],
	#classVars : [
		'EndMarkups',
		'Markups'
	],
	#category : 'Pillar2-PetitPillar'
}

{ #category : #accessing }
PR2PillarGrammar class >> defaultEndMarkups [
	| markups |
	markups := Dictionary new.
	markups
		at: PRAbstractAnnotation put: '}$';
		at: PRRaw put: '}}}';
		at: PRCodeblock put: ']]]'.
	^ markups
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupAnnotationSeparator [
	^ $:
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupParameter [
	^ '|'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupParameterValue [
	^ '='
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupRawType [
	^ ':'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupReferenceAlias [
	^ '>'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupReferenceAnchor [
	^ '@'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupTableCenter [
	^ '|'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupTableHeader [
	^ '!'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupTableLeft [
	^ '{'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkupTableRight [
	^ '}'
]

{ #category : #accessing }
PR2PillarGrammar class >> defaultMarkups [
	^ self textMarkups , self lineMarkups
]

{ #category : #accessing }
PR2PillarGrammar class >> endMarkups [
	^ EndMarkups
]

{ #category : #accessing }
PR2PillarGrammar class >> endMarkups: anObject [
	EndMarkups := anObject
]

{ #category : #'class initialization' }
PR2PillarGrammar class >> initialize [
	Markups := self defaultMarkups.
	EndMarkups := self defaultEndMarkups.
]

{ #category : #accessing }
PR2PillarGrammar class >> lineMarkups [
	| markups |
	markups := Dictionary new.
	markups
		at: PRAnchor put: '@';
		at: PRHeader put: '!';
		at: PROrderedList put: '#';
		at: PRUnorderedList put: '-';
		at: PRDataItem put: ':';
		at: PRTermItem put: ';';
		at: PRAnnotatedParagraph put: '@@';
		at: PRPreformatted put: '= ';
		at: PRHorizontalRule put: '_';
		at: PRCommentedLine put: '%';
		at: PRTableCell put: '|'.
	^ markups
]

{ #category : #accessing }
PR2PillarGrammar class >> markups [
	^ Markups
]

{ #category : #accessing }
PR2PillarGrammar class >> markups: anObject [
	Markups := anObject
]

{ #category : #parsing }
PR2PillarGrammar class >> parse: aStringOrStream [
	| stream isSton ston doc |
	stream := aStringOrStream readStream.
	stream atEnd
		ifTrue: [ ^ PRDocument new ].
	isSton := stream next = ${ and: [ stream peek ~~ ${ ].
	stream skip: -1.
	ston := isSton
		ifTrue: [ (STON reader on: stream) next ]
		ifFalse: [ Dictionary new ].
	doc := super parse: stream upToEnd.
	ston keysAndValuesDo: [ :key :value | doc propertyAt: key put: value ].
	^ doc
]

{ #category : #accessing }
PR2PillarGrammar class >> textMarkups [
	| markups |
	markups := Dictionary new.
	markups
		at: PRBoldFormat put: '""';
		at: PRItalicFormat put: '''''';
		at: PRMonospaceFormat put: '==';
		at: PRStrikethroughFormat put: '--';
		at: PRSubscriptFormat put: '@@';
		at: PRSuperscriptFormat put: '^^';
		at: PRUnderlineFormat put: '__';
		at: PRFigure put: '+';
		at: PRLink put: '*';
		at: PRCodeblock put: '[[[';
		at: PRRaw put: '{{{';
		at: PRAbstractAnnotation put: '${'.
	^ markups
]

{ #category : #'grammar - Anchor' }
PR2PillarGrammar >> anchor [
	^ (Markups at: PRAnchor) asPParser , lineEnd negate plus flatten
]

{ #category : #'grammar - Paragraph' }
PR2PillarGrammar >> annotatedParagraph [
	^	epsilonToken , 
		(Markups at: PRAnnotatedParagraph) asPParser , 
		($  asPParser / newline) negate star flatten , 
		($  asPParser , oneLineContent) optional ,
		epsilonToken 
]

{ #category : #'grammar - Annotation' }
PR2PillarGrammar >> annotation [
	self flag: #todo.	"An annotation should have the possibility to be outside of a paragraph."
	^	epsilonToken , 	
		(Markups at: PRAbstractAnnotation) asPParser , 
		annotationTag , 
		annotationParameters optional ,
		annotationEndMarkup , 
		epsilonToken ,
		#blank asPParser star
]

{ #category : #'grammar - Annotation' }
PR2PillarGrammar >> annotationEndMarkup [
	^ (EndMarkups at: PRAbstractAnnotation) asPParser
]

{ #category : #'grammar - Annotation' }
PR2PillarGrammar >> annotationMarkupSeparator [
	^ self class defaultMarkupAnnotationSeparator asPParser
]

{ #category : #'grammar - Annotation' }
PR2PillarGrammar >> annotationParameters [
	^ (annotationMarkupSeparator , parametersUntilEndAnnotation) ==> [ :array | array second ]
]

{ #category : #'grammar - Annotation' }
PR2PillarGrammar >> annotationTag [
	^ (escapedCharacter / annotationMarkupSeparator / annotationEndMarkup) negate plus
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> boldFormat [
	^ self formatFor: boldMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> boldMarkup [
	^ (Markups at: PRBoldFormat) asPParser
]

{ #category : #'grammar - Text' }
PR2PillarGrammar >> commentedLine [
	^ (Markups at: PRCommentedLine) asPParser , lineEnd negate star flatten
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> content [
	^ oneLineContent , lineBreak optional
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> contents [
	^ content plus
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> dataBasicListItem [
	^ (dataMarkup trimBlanks, listMarkup not , oneLineContent optional , lineEnd)
		==> [ :array | array third ifNil: [ {} ] ]
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> dataListItem [
	self flag: #todo.	"This and the overriden method of the parser are REALLY bad. We parse several times the same input, this is bad."
	^	epsilonToken , 
		dataMarkup and , 
		dataBasicListItem optional , 
		((commentedLine , newline) ==> [ :array | array first ]) star , 
		dataSubListItem optional , 
		epsilonToken
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> dataMarkup [
	^ (Markups at: PRDataItem) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> dataSubListItem [
	^ ((dataMarkup , subList) / (commentedLine , newline) flatten) plus
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> definitionList [
	^ 	epsilonToken ,
		(termListItem / dataListItem) plus , 
		epsilonToken
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> document [
	"A document contain everything that can be at the top of a document. It can contain for example some headers, paragraph, tables etc."

	^ (elementsAtLineBeginning / paragraph) star
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> elementWithNewline [
	^ (header / annotatedParagraph / anchor / commentedLine / horizontalRule , lineEnd) ==> #first
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> elementsAtLineBeginning [
	^  elementWithNewline / list / script / table / commentedLine / preformatedText / emptyParagraph
]

{ #category : #'grammar - Paragraph' }
PR2PillarGrammar >> emptyParagraph [
	^ newline
]

{ #category : #'grammar - Helper' }
PR2PillarGrammar >> epsilonToken [
	^ #epsilon asPParser token
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> escapedCharacter [
	^ ($\ asPParser , #any asPParser) ==> #second
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> figure [
	^ figureMarkup , figureAlias optional , referenceFigure , parametersFigure optional , figureMarkup
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> figureAlias [
	^ ((escapedCharacter / (figureMarkup / referenceAliasMarkup) negate) star flatten, referenceAliasMarkup) ==> #first
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> figureMarkup [
	^ (Markups at: PRFigure) asPParser
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> figureReference [
	^ (figureMarkup / parameterMarkup) negate plus flatten
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> format [
	self flag: 'Now a format can be empty (use of star instead of plus in these parsers). Do we really want this ? Some unit tests specify that a format can be empty but we can remove them'.
	^ monospaceFormat / boldFormat / italicFormat / underlineFormat / strikethroughFormat / subscriptFormat / superscriptFormat
]

{ #category : #'from markdown' }
PR2PillarGrammar >> formatContent [
	^ 	epsilonToken ,
		(escapedCharacter / specialFormatMarkups negate) plus ,
		epsilonToken
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> formatFor: aMarkupParser [
	^ 	epsilonToken ,
		aMarkupParser , 
		(aMarkupParser not , ( otherContent / formatContent)) star , 
		aMarkupParser,
		epsilonToken
]

{ #category : #'grammar - Header' }
PR2PillarGrammar >> header [
	"A header begin by a certain amount of $! and contains a text and/or some formatedText"

	^ 	epsilonToken ,
		(Markups at: PRHeader) asPParser plus , 
		oneLineContent optional trimBlanks , 
		epsilonToken
]

{ #category : #'grammar - HorizontalRule' }
PR2PillarGrammar >> horizontalRule [
	^ (Markups at: PRHorizontalRule) asPParser , #blank asPParser star
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> italicFormat [
	^ self formatFor: italicMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> italicMarkup [
	^ (Markups at: PRItalicFormat) asPParser
]

{ #category : #'grammar - Text' }
PR2PillarGrammar >> lineBreak [
	^ newline , elementsAtLineBeginning not
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> lineEnd [
	^ newline / #eoi asPParser
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> link [
	^ 	epsilonToken , 
		linkMarkup , 
		linkAlias optional , 
		referenceLink , 
		parametersLink optional , 
		linkMarkup ,
		epsilonToken
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> linkAlias [
	^ ((escapedCharacter / (linkMarkup / referenceAliasMarkup) negate) star flatten, referenceAliasMarkup) ==> #first
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> linkMarkup [
	^ (Markups at: PRLink) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> list [
	self flag: #todo.	"The list elements should be trim."
	^ (unorderedList / orderedList / definitionList) memoize
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> listMarkup [
	^ orderedMarkup / unorderedMarkup / termMarkup / dataMarkup
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> lists [
	^ list plus
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> monospaceFormat [
	^ self formatFor: monospaceMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> monospaceMarkup [
	^ (Markups at: PRMonospaceFormat) asPParser
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> newline [
	^ String crlf asPParser / String lf asPParser / String cr asPParser
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> oneLineContent [
	^ (otherContent / text) plus
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> orderedBasicListItem [
	^ (orderedMarkup trimBlanks, listMarkup not , oneLineContent optional , lineEnd)
		==> [ :array | array third ifNil: [ {} ] ]
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> orderedList [
	^ 	epsilonToken , 
		orderedListItem plus , 
		epsilonToken
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> orderedListItem [
	self flag: #todo.	"This and the overriden method of the parser are REALLY bad. We parse several times the same input, this is bad."
	^	epsilonToken , 
		orderedMarkup and , 
		orderedBasicListItem optional , 
		((commentedLine , newline) ==> [ :array | array first ]) star , 
		orderedSubListItem optional ,
		epsilonToken
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> orderedMarkup [
	^ (Markups at: PROrderedList) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> orderedSubListItem [
	^ ((orderedMarkup , subList) / (commentedLine , newline) flatten) plus
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> otherContent [
	^ format / annotation / reference / raw
]

{ #category : #'grammar - Paragraph' }
PR2PillarGrammar >> paragraph [
	^ contents , lineEnd
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterKeyUntilEndAnnotation [
	^ self parameterKeyUntilParser: annotationEndMarkup
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterKeyUntilEndFigure [
	^ self parameterKeyUntilParser: figureMarkup
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterKeyUntilEndLink [
	^ self parameterKeyUntilParser: linkMarkup
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterKeyUntilNewline [
	^ self parameterKeyUntilParser: newline
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterKeyUntilParser: aParser [
	^ (escapedCharacter / (aParser / parameterMarkup / parameterValueMarkup) negate) star
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterMarkup [
	^ self class defaultMarkupParameter asPParser
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterUntilEndAnnotation [
	^ parameterKeyUntilEndAnnotation , parameterValueUntilEndAnnotation optional
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterUntilEndFigure [
	^ parameterKeyUntilEndFigure , parameterValueUntilEndFigure optional
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterUntilEndLink [
	^ parameterKeyUntilEndLink , parameterValueUntilEndLink optional
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterUntilNewline [
	^ parameterKeyUntilNewline , parameterValueUntilNewline optional
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValue [
	^ (figureMarkup / parameterMarkup) negate star flatten
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValueMarkup [
	^ self class defaultMarkupParameterValue asPParser
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValueUntilEndAnnotation [
	^ self parameterValueUntilParser: annotationEndMarkup
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValueUntilEndFigure [
	^ self parameterValueUntilParser: figureMarkup
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValueUntilEndLink [
	^ self parameterValueUntilParser: linkMarkup
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValueUntilNewline [
	^ self parameterValueUntilParser: newline
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parameterValueUntilParser: aParser [
	^ (parameterValueMarkup , (escapedCharacter / (aParser / parameterMarkup) negate) star) ==> [ :array | array second ]
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> parametersFigure [
	^ (parameterMarkup , parametersUntilEndFigure) ==> [ :array | array second ]
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> parametersLink [
	^ (parameterMarkup , parametersUntilEndLink) ==> #second
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parametersUntilEndAnnotation [
	^ parameterUntilEndAnnotation , ((parameterMarkup , parameterUntilEndAnnotation) ==> [ :array | array second ]) star
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parametersUntilEndFigure [
	^ parameterUntilEndFigure
		, ((parameterMarkup , parameterUntilEndFigure) ==> [ :array | array second ]) star
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parametersUntilEndLink [
	^ parameterUntilEndLink
		, ((parameterMarkup , parameterUntilEndLink) ==> [ :array | array second ]) star
]

{ #category : #'grammar - Parameter' }
PR2PillarGrammar >> parametersUntilNewline [
	^ parameterUntilNewline , ((parameterMarkup , parameterUntilNewline) ==> [ :array | array second ]) star
]

{ #category : #'grammar - Text' }
PR2PillarGrammar >> preformatedLine [
	^ (Markups at: PRPreformatted) asPParser , lineEnd negate star flatten , lineEnd
]

{ #category : #'grammar - Text' }
PR2PillarGrammar >> preformatedText [
	^ preformatedLine plus
]

{ #category : #'grammar - Raw' }
PR2PillarGrammar >> raw [
	^ (Markups at: PRRaw) asPParser , rawType optional
		, rawEndMarkup negate star flatten , rawEndMarkup
]

{ #category : #'grammar - Raw' }
PR2PillarGrammar >> rawEndMarkup [
	^ (EndMarkups at: PRRaw) asPParser
]

{ #category : #'grammar - Raw' }
PR2PillarGrammar >> rawType [
	^ (rawEndMarkup / rawTypeMarkup) negate plus flatten , rawTypeMarkup ==> [ :array | array first ] 
]

{ #category : #'grammar - Raw' }
PR2PillarGrammar >> rawTypeMarkup [
	^ self class defaultMarkupRawType asPParser
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> reference [
	^ link / figure
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> referenceAliasMarkup [
	^ self class defaultMarkupReferenceAlias asPParser
]

{ #category : #'from markdown' }
PR2PillarGrammar >> referenceContent [
	^ (escapedCharacter / specialReferenceMarkups negate) plus
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> referenceFigure [
	^ self referenceUntil: figureMarkup
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> referenceLink [
	^ self referenceUntil: linkMarkup
]

{ #category : #'grammar - Reference' }
PR2PillarGrammar >> referenceUntil: aParser [
	^ (escapedCharacter / (aParser / parameterMarkup / newline) negate) plus
]

{ #category : #'grammar - Script' }
PR2PillarGrammar >> script [
	| endParser |
	endParser := newline asPParser , (EndMarkups at: PRCodeblock) asPParser , space star , lineEnd.
	^	epsilonToken, 
		(Markups at: PRCodeblock) asPParser , 
		scriptParameters , 
		endParser negate plus flatten , 
		endParser,
		epsilonToken
]

{ #category : #'grammar - Script' }
PR2PillarGrammar >> scriptParameters [
	^ parametersUntilNewline , newline ==> [ :array | array first ]
]

{ #category : #'from markdown' }
PR2PillarGrammar >> space [
	^ #blank asPParser
]

{ #category : #'from markdown' }
PR2PillarGrammar >> specialFormatMarkups [
	^ boldMarkup  / italicMarkup / monospaceMarkup / strikethroughMarkup / subscriptMarkup / superscriptMarkup / underlineMarkup
]

{ #category : #'from markdown' }
PR2PillarGrammar >> specialReferenceMarkups [
	^ referenceAliasMarkup / linkMarkup / figureMarkup
]

{ #category : #'grammar - Document' }
PR2PillarGrammar >> start [
	^ document end
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> strikethroughFormat [
	^ self formatFor: strikethroughMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> strikethroughMarkup [
	^ (Markups at: PRStrikethroughFormat) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> subList [
	^ (listMarkup plus , oneLineContent optional , lineEnd) flatten
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> subscriptFormat [
	^ self formatFor: subscriptMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> subscriptMarkup [
	^ (Markups at: PRSubscriptFormat) asPParser
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> superscriptFormat [
	^ self formatFor: superscriptMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> superscriptMarkup [
	^ (Markups at: PRSuperscriptFormat) asPParser
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> table [
	self flag: #todo. "Add the possibility to have comment inside a table. See PRPillarGrammarTest>>testTableWithComment."
	^ tableRow plus
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableAlignMarkup [
	^ tableCenterMarkup / tableLeftMarkup / tableRightMarkup
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableCell [
	| cellSeparator |
	cellSeparator := (Markups at: PRTableCell) asPParser.
	^ tableMarkups , (escapedCharacter / (cellSeparator / lineEnd) negate) star flatten
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableCenterMarkup [
	^ self class defaultMarkupTableCenter asPParser
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableHeadingMarkup [
	^ self class defaultMarkupTableHeader asPParser
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableLeftMarkup [
	^ self class defaultMarkupTableLeft asPParser
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableMarkups [
	| optionalParser |
	self flag: #todo.	"In the future we will define the alignement before the headind."
	optionalParser := (tableAlignMarkup / tableHeadingMarkup) optional.
	^ (Markups at: PRTableCell) asPParser , optionalParser , optionalParser
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableRightMarkup [
	^ self class defaultMarkupTableRight asPParser
]

{ #category : #'grammar - Table' }
PR2PillarGrammar >> tableRow [
	^ tableCell plus , lineEnd
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> termBasicListItem [
	^ (termMarkup trimBlanks, listMarkup not , oneLineContent optional , lineEnd)
		==> [ :array | array third ifNil: [ {} ] ]
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> termListItem [
	self flag: #todo.	"This and the overriden method of the parser are REALLY bad. We parse several times the same input, this is bad."
	^	epsilonToken , 
		termMarkup and , 
		termBasicListItem optional , 
		((commentedLine , newline) ==> [ :array | array first ]) star , 
		termSubListItem optional , 
		epsilonToken 
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> termMarkup [
	^ (Markups at: PRTermItem) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> termSubListItem [
	^ ((termMarkup , subList) / (commentedLine , newline) flatten) plus
]

{ #category : #'grammar - Text' }
PR2PillarGrammar >> text [
	"Everything that is a pure text and nothing else (not a format, not a link, ...)"
	^  epsilonToken, 
		(escapedCharacter / ((newline , elementsAtLineBeginning) / otherContent / lineEnd) negate) plus, 
		epsilonToken
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> underlineFormat [
	^ self formatFor: underlineMarkup
]

{ #category : #'grammar - Format' }
PR2PillarGrammar >> underlineMarkup [
	^ (Markups at: PRUnderlineFormat) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> unorderedBasicListItem [
	^ (unorderedMarkup trimBlanks, listMarkup not , oneLineContent optional , lineEnd)
		==> [ :array | array third ifNil: [ {} ] ]
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> unorderedList [
	^ 	epsilonToken , 
		unorderedListItem plus , 
		epsilonToken
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> unorderedListItem [
	self flag: #todo.	"This and the overriden method of the parser are REALLY bad. We parse several times the same input, this is bad."
	^	epsilonToken , 
		unorderedMarkup and , 
		unorderedBasicListItem optional , 
		((commentedLine , newline) ==> [ :array | array first ]) star , 
		unorderedSubListItem optional ,
		epsilonToken
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> unorderedMarkup [
	^ (Markups at: PRUnorderedList) asPParser
]

{ #category : #'grammar - List' }
PR2PillarGrammar >> unorderedSubListItem [
	^ ((unorderedMarkup , subList) / (commentedLine , newline) flatten) plus
]
