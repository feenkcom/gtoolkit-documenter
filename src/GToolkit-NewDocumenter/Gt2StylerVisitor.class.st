Class {
	#name : #Gt2StylerVisitor,
	#superclass : #PRVisitor,
	#traits : 'TBlDebug + TGt2DocumentConstants + TGt2DocumentUtility',
	#classTraits : 'TBlDebug classTrait + TGt2DocumentConstants classTrait + TGt2DocumentUtility classTrait',
	#instVars : [
		'text',
		'document',
		'subscriber',
		'codeblockCounter',
		'annotationCounter',
		'listItemStyler',
		'currentList',
		'colorStyler',
		'symbolStyler'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #accessing }
Gt2StylerVisitor >> colorStyler [
	^ colorStyler ifNil: [ colorStyler := Gt2ColorStyler new ].
]

{ #category : #accessing }
Gt2StylerVisitor >> document [
	<return: #Gt2Document>
	^ document
]

{ #category : #accessing }
Gt2StylerVisitor >> document: aGt2Document [
	self 
		assert: [ aGt2Document notNil ]
		description: [ 'Document must be non-nil' ].
	document := aGt2Document
]

{ #category : #'private - styling' }
Gt2StylerVisitor >> hideSimetricMarkupsFor: aPRFormat [
	| aMarkup |
	aMarkup := self utility startMarkupFor: aPRFormat.

	(self text 
		from: aPRFormat start
		to: aPRFormat start + aMarkup size - 1)
			attribute: Gt2HideAttribute uniqueInstance.
	(self text 
		from: aPRFormat stop - aMarkup size + 1
		to: aPRFormat stop)
			attribute: Gt2HideAttribute uniqueInstance.
]

{ #category : #initialization }
Gt2StylerVisitor >> initialize [
	super initialize.
	codeblockCounter := 0.
	annotationCounter := 0.
	listItemStyler := Gt2NullListItemStyler uniqueInstance.
]

{ #category : #accessing }
Gt2StylerVisitor >> subscriber [
	^ subscriber
]

{ #category : #accessing }
Gt2StylerVisitor >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #accessing }
Gt2StylerVisitor >> symbolStyler [
	^ symbolStyler ifNil: [ symbolStyler := Gt2SymbolStyler new ].
]

{ #category : #accessing }
Gt2StylerVisitor >> text [
	<return: #BlRope>
	^ text
]

{ #category : #accessing }
Gt2StylerVisitor >> text: aBlRope [
	self
		assert: [ aBlRope notNil ] 
		description: [ 'Styled text must be non-nil' ].
	text := aBlRope
]

{ #category : #'visiting-annotations' }
Gt2StylerVisitor >> visitAnnotation: anAnnotation [
	annotationCounter := annotationCounter + 1.
	anAnnotation 
		counter: annotationCounter;
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitBoldFormat: aPRBoldFormat [
	(self text
		from: aPRBoldFormat start
		to: aPRBoldFormat stop)
			bold.
	self hideSimetricMarkupsFor: aPRBoldFormat.
	super visitBoldFormat: aPRBoldFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCodeblock: aPRCodeblock [
	codeblockCounter := codeblockCounter + 1.
	aPRCodeblock 
		counter: codeblockCounter;
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitCodeblock: aPRCodeblock
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCommentedLine: aPRCommentedLine [
	aPRCommentedLine 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitCommentedLine: aPRCommentedLine
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitDefinitionList: aPRDefinitionList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := self colorStyler changeColor.
	super visitDefinitionList: aPRDefinitionList.
	listItemStyler := aPreviousListStyler.
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitExternalLink: anPRExternalLine [
	anPRExternalLine 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitExternalLink: anPRExternalLine
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitFigure: aPRFigure [
	aPRFigure 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleInText: self text.
	super visitFigure: aPRFigure
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitHeader: aPRHeader [
	(self text
		from: aPRHeader start
		to: aPRHeader stop)
			fontSize: self constants headerFontSize - (aPRHeader level * self constants headerLevelStep)";
			paragraphMargin: (BlInsets top: 15 left: 20 bottom: 15 right: 20)".
	super visitHeader: aPRHeader
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitItalicFormat: aPRItalicFormat [
	(self text
		from: aPRItalicFormat start
		to: aPRItalicFormat stop)
			italic.
	self hideSimetricMarkupsFor: aPRItalicFormat.
	super visitItalicFormat: aPRItalicFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitList: aPRList [
	"(self text from: aPRList start to: aPRList stop)
		paragraphMargin: (BlInsets top: 15 left: 20 bottom: 15 right: 20)."
	super visitList: aPRList.
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitListItem: aPRListItem [
	listItemStyler style: self text at: aPRListItem.
	super visitListItem: aPRListItem
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitMonospaceFormat: aPRMonospaceFormat [
	(self text
		from: aPRMonospaceFormat start
		to: aPRMonospaceFormat stop)
			monospace.
	self hideSimetricMarkupsFor: aPRMonospaceFormat.
	super visitMonospaceFormat: aPRMonospaceFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitOrderedList: aPROrderedList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := Gt2CounterStyler new.
	super visitOrderedList: aPROrderedList.
	listItemStyler := aPreviousListStyler.
]

{ #category : #'visiting-parameters' }
Gt2StylerVisitor >> visitParameter: aPRParameter [
	aPRParameter isValid ifFalse: [ 
		(self text
			from: aPRParameter start 
			to: (aPRParameter start max: aPRParameter stop))
				foreground: self constants linkWithErrorColor ].
	super visitParameter: aPRParameter
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitRaw: aPRRaw [
	aPRRaw start ifNil: [ ^ self ].
	self flag: 'fix Pillar'.
	(self text
		from: aPRRaw start
		to: aPRRaw stop)
			monospace.
	super visitRaw: aPRRaw
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitStrikethroughFormat: aPRStrikethroughFormat [
	(self text
		from: aPRStrikethroughFormat start
		to: aPRStrikethroughFormat stop)
			foreground: self constants subtleColor.
	self hideSimetricMarkupsFor: aPRStrikethroughFormat.
	super visitStrikethroughFormat: aPRStrikethroughFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitSubscriptFormat: aPRSubscriptFormat [
	(self text
		from: aPRSubscriptFormat start
		to: aPRSubscriptFormat stop)
			foreground: self constants subtleColor";
			fontSize: self constants superscriptFontSize;
			wordPadding: (BlInsets all: 30)".
	self hideSimetricMarkupsFor: aPRSubscriptFormat.
	super visitSubscriptFormat: aPRSubscriptFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitSuperscriptFormat: aPRSuperscriptFormat [
	(self text
		from: aPRSuperscriptFormat start
		to: aPRSuperscriptFormat stop)
			foreground: self constants subtleColor;
			fontSize: self constants superscriptFontSize.
	self hideSimetricMarkupsFor: aPRSuperscriptFormat.
	super visitSuperscriptFormat: aPRSuperscriptFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitUndefinedAnnotation: anAnnotation [
	(self text
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color red.
	super visitUndefinedAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitUnderlineFormat: aPRUnderlineFormat [
	(self text
		from: aPRUnderlineFormat start
		to: aPRUnderlineFormat stop)
			underline.
	self hideSimetricMarkupsFor: aPRUnderlineFormat.
	super visitUnderlineFormat: aPRUnderlineFormat
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitUnorderedList: aPRUnorderedList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := self symbolStyler changeSymbol.
	super visitUnorderedList: aPRUnorderedList.
	listItemStyler := aPreviousListStyler.
]
