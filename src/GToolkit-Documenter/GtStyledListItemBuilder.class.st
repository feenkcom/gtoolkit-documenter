Class {
	#name : #GtStyledListItemBuilder,
	#superclass : #GtStyledNodeBuilder,
	#instVars : [
		'itemStyler'
	],
	#category : #'GToolkit-Documenter-Styler Builder'
}

{ #category : #'style - adorn list item symbol' }
GtStyledListItemBuilder >> adornListItemSymbolInMarkupViewMode [
	"Adorn a list item symbol in markup view mode"
	self itemStyler adornListItemSymbolInMarkupViewModeInContext: self
]

{ #category : #'style - adorn list item symbol' }
GtStyledListItemBuilder >> adornListItemSymbolInNoMarkupViewMode [
	"Style a list item symbol in no-markup view mode 
	(as it should be visible in a VISIWIG editor)"
	self itemStyler adornListItemSymbolInNoMarkupViewModeInContext: self
]

{ #category : #'style - hide' }
GtStyledListItemBuilder >> autoHideListItemSymbol [
	"Hide list item symbol adornments only if a cursor is far away"
	self 
		if: self isCursorCloseListItemSymbol
		do: [ self revealListItemSymbolMarkup ]
		otherwise: [ self hideListItemSymbolMarkup ].
	self installDisplayMarkupsHandler
]

{ #category : #'style - adorn list item symbol' }
GtStyledListItemBuilder >> clearAdornments [
	self itemStyler clearAdornmentsInContext: self.
]

{ #category : #'style - hide' }
GtStyledListItemBuilder >> hideListItemSymbolMarkup [
	self clearAdornments.
	self adornListItemSymbolInNoMarkupViewMode.
]

{ #category : #'style - hide' }
GtStyledListItemBuilder >> installDisplayMarkupsHandler [
	"Display markups if a cursor is close to the list item symbol"
	self cursorEnterAction: [ :aTextEditor |
		self updateText: aTextEditor text.
		self revealListItemSymbolMarkup ].
	self cursorLeaveAction: [ :aTextEditor |
		self updateText: aTextEditor text.
		self hideListItemSymbolMarkup ].
	self activateCursorFrom: self listItemSymbolStart to: self listItemSymbolStop.
]

{ #category : #testing }
GtStyledListItemBuilder >> isCursorCloseListItemSymbol [
	"Return true if a cursor is close to the list item symbol, e.g., #, -"
	<return: #Boolean>
	^ self isCursorCloseTo: self listItemSymbolStart and: self listItemSymbolStop
]

{ #category : #accessing }
GtStyledListItemBuilder >> itemStyler [
	<return: #GtListItemStyler>
	^ itemStyler
]

{ #category : #accessing }
GtStyledListItemBuilder >> itemStyler: aGtListItemStyler [
	self 
		assert: [ aGtListItemStyler isNotNil ] 
		description: [ 'List item styler must be non-nil' ].
	itemStyler := aGtListItemStyler
]

{ #category : #'accessing - list item symbol' }
GtStyledListItemBuilder >> listItemSymbolStart [
	<return: #Integer>

	^ (self start - 1) max: 1
]

{ #category : #'accessing - list item symbol' }
GtStyledListItemBuilder >> listItemSymbolStop [
	<return: #Integer>
	^ self start
]

{ #category : #'accessing - list item symbol' }
GtStyledListItemBuilder >> listItemSymbolText [
	<return: #BlText>
	^ self text from: self listItemSymbolStart to: self listItemSymbolStop
]

{ #category : #'style - hide' }
GtStyledListItemBuilder >> revealListItemSymbolMarkup [
	self clearAdornments.
	self adornListItemSymbolInMarkupViewMode.
]
