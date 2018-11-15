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
		'symbolStyler',
		'mode'
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

{ #category : #initialization }
Gt2StylerVisitor >> initialize [
	super initialize.
	codeblockCounter := 0.
	annotationCounter := 0.
	listItemStyler := Gt2NullListItemStyler uniqueInstance.
]

{ #category : #accessing }
Gt2StylerVisitor >> mode [
	<return: #Gt2StylerStrategy>
	^ mode
]

{ #category : #accessing }
Gt2StylerVisitor >> mode: aGt2StylerStrategy [
	self 
		assert: [ aGt2StylerStrategy notNil ] 
		description: [ 'Styling strategy must be non-nil' ].
	mode := aGt2StylerStrategy
]

{ #category : #'private - styling' }
Gt2StylerVisitor >> styleNode: aPRDocumentItem [
	aPRDocumentItem
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleText: self text inMode: self mode
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
	anAnnotation counter: annotationCounter.
	super visitAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCodeblock: aPRCodeblock [
	codeblockCounter := codeblockCounter + 1.
	aPRCodeblock 
		counter: codeblockCounter;
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleText: self text.
	super visitCodeblock: aPRCodeblock
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitCommentedLine: aPRCommentedLine [
	aPRCommentedLine 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleText: self text.
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
Gt2StylerVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self styleNode: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitDocumentItem: aPRDocumentItem [
	self styleNode: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitFigure: aPRFigure [
	aPRFigure 
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleText: self text.
	super visitFigure: aPRFigure
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
Gt2StylerVisitor >> visitUndefinedAnnotation: anAnnotation [
	(self text
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color red.
	super visitUndefinedAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
Gt2StylerVisitor >> visitUnorderedList: aPRUnorderedList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := self symbolStyler changeSymbol.
	super visitUnorderedList: aPRUnorderedList.
	listItemStyler := aPreviousListStyler.
]
