Class {
	#name : #GtStylerVisitor,
	#superclass : #GtDocumentVisitor,
	#instVars : [
		'text',
		'subscriber',
		'annotationCounter',
		'listItemStyler',
		'currentList',
		'colorStyler',
		'symbolStyler',
		'mode'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtStylerVisitor class >> constants [
	^ GtDocumentConstants
]

{ #category : #private }
GtStylerVisitor class >> utility [
	^ GtDocumentUtility
]

{ #category : #accessing }
GtStylerVisitor >> colorStyler [
	^ colorStyler ifNil: [ colorStyler := GtColorStyler new ].
]

{ #category : #accessing }
GtStylerVisitor >> constants [
	^ GtDocumentConstants
]

{ #category : #initialization }
GtStylerVisitor >> initialize [
	super initialize.
	annotationCounter := 0.
	listItemStyler := GtNullListItemStyler uniqueInstance.
]

{ #category : #accessing }
GtStylerVisitor >> mode [
	<return: #GtStylerStrategy>
	^ mode
]

{ #category : #accessing }
GtStylerVisitor >> mode: aGt2StylerStrategy [
	self 
		assert: [ aGt2StylerStrategy notNil ] 
		description: [ 'Styling strategy must be non-nil' ].
	mode := aGt2StylerStrategy
]

{ #category : #'private - styling' }
GtStylerVisitor >> styleNode: aPRDocumentItem [
	aPRDocumentItem
		gtDocument: self document;
		gtSubscriber: self subscriber;
		styleText: self text using: self mode
]

{ #category : #accessing }
GtStylerVisitor >> subscriber [
	^ subscriber
]

{ #category : #accessing }
GtStylerVisitor >> subscriber: anObject [
	subscriber := anObject
]

{ #category : #accessing }
GtStylerVisitor >> symbolStyler [
	^ symbolStyler ifNil: [ symbolStyler := GtSymbolStyler new ].
]

{ #category : #accessing }
GtStylerVisitor >> text [
	<return: #BlRope>
	^ text
]

{ #category : #accessing }
GtStylerVisitor >> text: aBlRope [
	self
		assert: [ aBlRope notNil ] 
		description: [ 'Styled text must be non-nil' ].
	text := aBlRope
]

{ #category : #private }
GtStylerVisitor >> utility [
	^ GtDocumentUtility
]

{ #category : #'visiting-annotations' }
GtStylerVisitor >> visitAnnotation: anAnnotation [
	annotationCounter := annotationCounter + 1.
	anAnnotation counter: annotationCounter.
	super visitAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitCommentedLine: aPRCommentedLine [
	self styleNode: aPRCommentedLine.
	super visitCommentedLine: aPRCommentedLine
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitDefinitionList: aPRDefinitionList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := self colorStyler changeColor.
	super visitDefinitionList: aPRDefinitionList.
	listItemStyler := aPreviousListStyler.
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitDocumentGroup: aPRDocumentGroup [
	self styleNode: aPRDocumentGroup.
	super visitDocumentGroup: aPRDocumentGroup.
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitDocumentItem: aPRDocumentItem [
	self styleNode: aPRDocumentItem.
	super visitDocumentItem: aPRDocumentItem.
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitList: aPRList [
	"(self text from: aPRList start to: aPRList stop)
		paragraphMargin: (BlInsets top: 15 left: 20 bottom: 15 right: 20)."
	super visitList: aPRList.
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitListItem: aPRListItem [
	aPRListItem gtListItemStyler: listItemStyler updateForNewListItem copy.
	super visitListItem: aPRListItem
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitOrderedList: aPROrderedList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := GtCounterStyler new.
	super visitOrderedList: aPROrderedList.
	listItemStyler := aPreviousListStyler.
]

{ #category : #'visiting-parameters' }
GtStylerVisitor >> visitParameter: aPRParameter [
	aPRParameter isValid ifFalse: [ 
		(self text
			from: aPRParameter start 
			to: (aPRParameter start max: aPRParameter stop))
				foreground: self constants linkWithErrorColor ].
	super visitParameter: aPRParameter
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitRaw: aPRRaw [
	aPRRaw start ifNil: [ ^ self ].
	self flag: 'fix Pillar'.
	(self text
		from: aPRRaw start
		to: aPRRaw stop)
			monospace.
	super visitRaw: aPRRaw
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitUndefinedAnnotation: anAnnotation [
	(self text
		from: anAnnotation start 
		to: anAnnotation stop)
			foreground: Color red.
	super visitUndefinedAnnotation: anAnnotation
]

{ #category : #'visiting-document' }
GtStylerVisitor >> visitUnorderedList: aPRUnorderedList [
	| aPreviousListStyler |
	aPreviousListStyler := listItemStyler.
	listItemStyler := self symbolStyler changeSymbol.
	super visitUnorderedList: aPRUnorderedList.
	listItemStyler := aPreviousListStyler.
]
