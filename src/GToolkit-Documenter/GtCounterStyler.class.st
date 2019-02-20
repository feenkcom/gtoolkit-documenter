Class {
	#name : #GtCounterStyler,
	#superclass : #GtListItemStyler,
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #accessing }
GtCounterStyler >> cursorLeftInText: aBlRope forNode: aPRListItem [
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			clearAttributes: [ :eachAttribute | 
				eachAttribute class = BrTextAdornmentDynamicAttribute ].
	self styleIndexWithoutMarkupInText: aBlRope forNode: aPRListItem.
	
]

{ #category : #accessing }
GtCounterStyler >> cursorNearbyInText: aBlRope forNode: aPRListItem [
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			clearAttributes: [ :eachAttribute | 
				eachAttribute class = BrTextAdornmentDynamicAttribute ].
	self styleIndexWithMarkupInText: aBlRope forNode: aPRListItem.
]

{ #category : #initialization }
GtCounterStyler >> initialize [
	super initialize.
	counter := 0.
]

{ #category : #private }
GtCounterStyler >> styleIndexWithMarkupInText: aBlRope forNode: aPRListItem [
	| anItemIndex |
	anItemIndex := aPRListItem gtListItemIndex asString asRopedText.
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						| indexText |
						indexText := anItemIndex asRopedText.
						indexText fontSize: self constants superscriptFontSize.
						indexText foreground: self constants subtleColor.
						BlTextElement new 
							text: indexText; 
							clipChildren: false;
							looseMesurement; 
							ascentBaseline ] }.
]

{ #category : #private }
GtCounterStyler >> styleIndexWithoutMarkupInText: aBlRope forNode: aPRListItem [
	| anItemIndexText |
	anItemIndexText := (aPRListItem gtListItemIndex asString, '.') asRopedText.
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beReplace;
					stencil: [
						BlTextElement new 
							text: anItemIndexText;
							margin: (BlInsets top: 3 bottom: 0);
							looseMesurement; 
							ascentBaseline ] }.
]

{ #category : #accessing }
GtCounterStyler >> styleTextWithMarkup: aBlRope forNode: aPRListItem [ 
	counter := counter + 1.
	aPRListItem gtListItemIndex: counter.
	self styleIndexWithMarkupInText: aBlRope forNode: aPRListItem
]

{ #category : #accessing }
GtCounterStyler >> styleTextWithoutMarkup: aBlRope forNode: aPRListItem [
	counter := counter + 1.
	aPRListItem gtListItemIndex: counter.
	self styleIndexWithoutMarkupInText: aBlRope forNode: aPRListItem.
	self utility 
		styleCursorAttributeInText: aBlRope 
		from: aPRListItem start 
		to: aPRListItem start + 1
		forNode: aPRListItem
]
