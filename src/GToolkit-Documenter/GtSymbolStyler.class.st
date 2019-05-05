Class {
	#name : #GtSymbolStyler,
	#superclass : #GtListItemStyler,
	#instVars : [
		'symbols',
		'symbolIndex'
	],
	#category : #'GToolkit-Documenter-Styler'
}

{ #category : #style }
GtSymbolStyler >> adornListItemSymbolInMarkupViewModeInContext: aGtStyledListItemBuilder [
	| aSymbol |
	aSymbol := self currentSymbol.
	aGtStyledListItemBuilder listItemSymbolText
		attributes: {
			BrTextAdornmentDynamicAttribute new 
				beAppend; 
				stencil: [
					| indexText |
					indexText := aSymbol asRopedText.
					indexText fontSize: self constants superscriptFontSize.
					indexText foreground: self constants subtleColor.
					BlTextElement new 
						text: indexText; 
						clipChildren: false;
						editorMesurement; 
						ascentBaseline ] }.
]

{ #category : #style }
GtSymbolStyler >> adornListItemSymbolInNoMarkupViewModeInContext: aGtStyledListItemBuilder [
	"Style a list item symbol in no-markup view mode 
	(as it should be visible in a VISIWIG editor).
	
	Do nothing in this case"
]

{ #category : #actions }
GtSymbolStyler >> changeSymbol [
	symbolIndex := (symbolIndex = symbols size)
		ifTrue: [ 1 ] 
		ifFalse: [ symbolIndex + 1 ].
]

{ #category : #accessing }
GtSymbolStyler >> currentSymbol [
	^ symbols at: symbolIndex
]

{ #category : #initialization }
GtSymbolStyler >> initialize [
	super initialize.
	symbols := '*-+'.
	symbolIndex := 1.
]
