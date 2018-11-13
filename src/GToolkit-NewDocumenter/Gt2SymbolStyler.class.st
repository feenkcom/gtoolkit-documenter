Class {
	#name : #Gt2SymbolStyler,
	#superclass : #Gt2ListItemStyler,
	#instVars : [
		'symbols',
		'symbolIndex'
	],
	#category : #'GToolkit-NewDocumenter-Styler'
}

{ #category : #actions }
Gt2SymbolStyler >> changeSymbol [
	symbolIndex := (symbolIndex = symbols size)
		ifTrue: [ 1 ] 
		ifFalse: [ symbolIndex + 1 ].
]

{ #category : #accessing }
Gt2SymbolStyler >> currentSymbol [
	^ symbols at: symbolIndex
]

{ #category : #initialization }
Gt2SymbolStyler >> initialize [
	super initialize.
	symbols := '*-+'.
	symbolIndex := 1.
]

{ #category : #actions }
Gt2SymbolStyler >> style: aBlRope at: aPRListItem [ 
	| aSymbol |
	aSymbol := self currentSymbol.
	(aBlRope
		from: aPRListItem start
		to: aPRListItem start)
			attributes: {
				BrTextAdornmentDynamicAttribute new 
					beAppend; 
					stencil: [
						| indexText |
						indexText := aSymbol asRopedText.
						indexText fontSize: self constants superscriptFontSize.
						indexText foreground: self constants subtleColor.
						BlTextElement new text: indexText ] }.
]
