Class {
	#name : 'GtColorStyler',
	#superclass : 'GtListItemStyler',
	#instVars : [
		'colorIndex',
		'colors'
	],
	#category : 'GToolkit-Documenter-Styler'
}

{ #category : 'style' }
GtColorStyler >> adornListItemSymbolInMarkupViewModeInContext: aGtStyledListItemBuilder [
	| aColor |
	aColor := self currentColor.
	aGtStyledListItemBuilder listItemSymbolText
		attributes: {
			BrTextAdornmentDynamicAttribute new 
				beAppend; 
				stencil: [
					BlElement new
						geometry: BlCircle new;
						size: 5@5;
						background: aColor ] }.
]

{ #category : 'style' }
GtColorStyler >> adornListItemSymbolInNoMarkupViewModeInContext: aGtStyledListItemBuilder [
	"Style a list item symbol in no-markup view mode 
	(as it should be visible in a VISIWIG editor).
	
	In this case do no thing"
]

{ #category : 'actions' }
GtColorStyler >> changeColor [
	colorIndex := (colorIndex = colors size)
		ifTrue: [ 1 ] 
		ifFalse: [ colorIndex + 1 ].
]

{ #category : 'accessing' }
GtColorStyler >> currentColor [
	^ colors at: colorIndex
]

{ #category : 'initialization' }
GtColorStyler >> initialize [
	super initialize.
	colors := { Color purple. Color lightOrange. }.
	colorIndex := 1.
]
