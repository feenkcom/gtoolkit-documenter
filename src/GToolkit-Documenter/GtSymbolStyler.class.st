Class {
	#name : #GtSymbolStyler,
	#superclass : #GtListItemStyler,
	#instVars : [
		'symbols',
		'symbolIndex'
	],
	#category : #'GToolkit-Documenter-Styler'
}

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

{ #category : #actions }
GtSymbolStyler >> styleTextWithMarkup: aBlRope forNode: aPRListItem [ 
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
						BlTextElement new 
							text: indexText; 
							clipChildren: false;
							editorMesurement; 
							ascentBaseline ] }.
]
