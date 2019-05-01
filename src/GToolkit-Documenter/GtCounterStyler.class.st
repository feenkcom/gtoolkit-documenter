Class {
	#name : #GtCounterStyler,
	#superclass : #GtListItemStyler,
	#instVars : [
		'counter'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #style }
GtCounterStyler >> adornListItemSymbolInMarkupViewModeInContext: aGtStyledListItemBuilder [
	| anItemIndex |
	anItemIndex := counter asString asRopedText
		fontSize: self constants superscriptFontSize;
		foreground: self constants subtleColor.
	aGtStyledListItemBuilder listItemSymbolText
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						BlTextElement new 
							text: anItemIndex; 
							clipChildren: false;
							editorMesurement; 
							ascentBaseline ] }.
]

{ #category : #style }
GtCounterStyler >> adornListItemSymbolInNoMarkupViewModeInContext: aGtStyledListItemBuilder [
	| anItemIndex |
	anItemIndex := (counter asString, '.') asRopedText
		glamorousRegularFont.
	aGtStyledListItemBuilder listItemSymbolText
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beReplace;
					stencil: [
						BlTextElement new 
							text: anItemIndex;
							margin: (BlInsets top: 0 bottom: 0);
							editorMesurement; 
							ascentBaseline ] }.
]

{ #category : #initialization }
GtCounterStyler >> initialize [
	super initialize.
	counter := 0.
]

{ #category : #style }
GtCounterStyler >> updateForNewListItem [
	"Update what every is needed to style new list item"
	counter := counter + 1.
]
